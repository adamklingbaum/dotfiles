#!/usr/bin/env bash
#
# Dotfiles bootstrap script
# Sets up a fresh macOS or Linux machine with personal dev config
#
# Usage:
#   ./install.sh              # Core setup only
#   ./install.sh --with-dev   # Include dev tools (Node, Ruby, Python via mise)
#

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"
INSTALL_DEV_TOOLS=false

# Parse arguments
for arg in "$@"; do
  case $arg in
    --with-dev)
      INSTALL_DEV_TOOLS=true
      shift
      ;;
  esac
done

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info() {
  echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
  echo -e "${GREEN}[OK]${NC} $1"
}

warn() {
  echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
  echo -e "${RED}[ERROR]${NC} $1"
  exit 1
}

# Detect OS
detect_os() {
  case "$(uname -s)" in
    Darwin) echo "macos" ;;
    Linux)  echo "linux" ;;
    *)      error "Unsupported OS: $(uname -s)" ;;
  esac
}

# Install Homebrew if not present
install_homebrew() {
  if command -v brew &>/dev/null; then
    success "Homebrew already installed"
    return
  fi

  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Add brew to PATH for this session
  if [[ "$OS" == "macos" ]]; then
    if [[ -f /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -f /usr/local/bin/brew ]]; then
      eval "$(/usr/local/bin/brew shellenv)"
    fi
  else
    # Linux
    if [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [[ -f "$HOME/.linuxbrew/bin/brew" ]]; then
      eval "$("$HOME/.linuxbrew/bin/brew" shellenv)"
    fi
  fi

  success "Homebrew installed"
}

# Install packages via Homebrew
install_packages() {
  info "Installing CLI packages..."

  local packages=(
    stow
    neovim
    git
    starship
    zsh-autosuggestions
    zsh-syntax-highlighting
    mise
  )

  for pkg in "${packages[@]}"; do
    if brew list "$pkg" &>/dev/null; then
      success "$pkg already installed"
    else
      info "Installing $pkg..."
      brew install "$pkg"
      success "$pkg installed"
    fi
  done
}

# Install casks (GUI apps and fonts) - macOS only
install_casks() {
  if [[ "$OS" != "macos" ]]; then
    warn "Casks only supported on macOS, skipping"
    return
  fi

  info "Installing casks..."

  local casks=(
    ghostty
    font-jetbrains-mono
  )

  for cask in "${casks[@]}"; do
    if brew list --cask "$cask" &>/dev/null; then
      success "$cask already installed"
    else
      info "Installing $cask..."
      brew install --cask "$cask"
      success "$cask installed"
    fi
  done
}

# Install dev tools via mise (Node, Ruby, Python)
install_dev_tools() {
  if [[ "$INSTALL_DEV_TOOLS" != true ]]; then
    return
  fi

  echo ""
  info "Installing dev tools via mise..."

  # Trust the config file (must trust the symlink target in home)
  mise trust "$HOME/.mise.toml"

  # Activate mise for this session
  eval "$(mise activate bash)"

  # Install all tools defined in .mise.toml
  info "Installing Node, Ruby, Python (this may take a few minutes)..."
  mise install

  success "Dev tools installed"

  # Show installed versions
  echo ""
  info "Installed versions:"
  mise list
}

# Backup existing config file/directory
backup_if_exists() {
  local target="$1"

  if [[ -e "$target" && ! -L "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    local backup_path="$BACKUP_DIR/$(basename "$target")"
    info "Backing up $target -> $backup_path"
    mv "$target" "$backup_path"
  elif [[ -L "$target" ]]; then
    # Remove existing symlink
    rm "$target"
  fi
}

# Get list of stow packages (directories with .config or dotfiles)
get_stow_packages() {
  local packages=()
  for dir in "$DOTFILES_DIR"/*/; do
    local name=$(basename "$dir")
    # Skip hidden dirs and common non-package dirs
    [[ "$name" == .* ]] && continue
    [[ "$name" == "scripts" ]] && continue
    packages+=("$name")
  done
  echo "${packages[@]}"
}

# Stow a single package with backup
stow_package() {
  local pkg="$1"
  local pkg_dir="$DOTFILES_DIR/$pkg"

  if [[ ! -d "$pkg_dir" ]]; then
    warn "Package $pkg not found, skipping"
    return
  fi

  info "Stowing $pkg..."

  # Find all target paths this package would create and backup existing ones
  # Handle .config directories
  if [[ -d "$pkg_dir/.config" ]]; then
    for item in "$pkg_dir/.config"/*; do
      [[ -e "$item" ]] || continue
      local name=$(basename "$item")
      backup_if_exists "$HOME/.config/$name"
    done
  fi

  # Handle direct dotfiles (files/dirs starting with .)
  for item in "$pkg_dir"/.*; do
    [[ -e "$item" ]] || continue
    local name=$(basename "$item")
    [[ "$name" == "." || "$name" == ".." ]] && continue
    [[ "$name" == ".config" ]] && continue
    backup_if_exists "$HOME/$name"
  done

  # Handle non-dot files that should go to home
  for item in "$pkg_dir"/*; do
    [[ -e "$item" ]] || continue
    local name=$(basename "$item")
    [[ "$name" == .* ]] && continue
    [[ -d "$item/.config" ]] && continue
    # Only backup if it's a direct home target
  done

  # Run stow
  stow -v -t "$HOME" -d "$DOTFILES_DIR" "$pkg"
  success "$pkg stowed"
}

# Main installation
main() {
  echo ""
  echo "========================================="
  echo "  Dotfiles Bootstrap"
  echo "========================================="
  echo ""

  OS=$(detect_os)
  info "Detected OS: $OS"

  # Install package manager
  install_homebrew

  # Install required packages
  install_packages

  # Install GUI apps and fonts (macOS)
  install_casks

  # Ensure .config directory exists
  mkdir -p "$HOME/.config"

  # Stow all packages
  echo ""
  info "Stowing dotfiles..."

  local packages=($(get_stow_packages))
  if [[ ${#packages[@]} -eq 0 ]]; then
    warn "No stow packages found"
  else
    for pkg in "${packages[@]}"; do
      stow_package "$pkg"
    done
  fi

  # Install dev tools if requested
  install_dev_tools

  # Summary
  echo ""
  echo "========================================="
  echo -e "  ${GREEN}Setup Complete!${NC}"
  echo "========================================="
  echo ""

  if [[ -d "$BACKUP_DIR" ]]; then
    info "Backups saved to: $BACKUP_DIR"
  fi

  echo ""
  echo "Next steps:"
  echo "  1. Open Ghostty (your new terminal)"
  echo "  2. Starship prompt should appear automatically"
  echo "  3. Run 'nvim' - lazy.nvim will auto-install on first launch"
  if [[ "$INSTALL_DEV_TOOLS" == true ]]; then
    echo "  4. Node, Ruby, Python are ready - run 'mise list' to see versions"
  else
    echo ""
    echo "Optional: Run './install.sh --with-dev' to install Node, Ruby, Python"
  fi
  echo ""
}

main "$@"
