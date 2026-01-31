# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start (Fresh Machine)

One command to set up everything on a new macOS or Linux machine:

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/repos/dotfiles
cd ~/repos/dotfiles
./install.sh
```

**With dev tools** (Node, Ruby, Python):
```bash
./install.sh --with-dev
```

The bootstrap script will:
- Install Homebrew (if not present)
- Install CLI tools (stow, neovim, git, starship, zsh plugins, mise)
- Install apps (Ghostty terminal, JetBrains Mono font) - macOS only
- Backup any existing config files to `~/.dotfiles-backup/`
- Stow all configurations
- Optionally install Node/pnpm, Ruby, Python via mise

## Manual Installation

If you prefer to install things manually:

### Prerequisites

```bash
brew install stow neovim starship zsh-autosuggestions zsh-syntax-highlighting
brew install --cask ghostty font-jetbrains-mono
```

### Stow Individual Configs

```bash
cd ~/repos/dotfiles
stow -t ~ nvim      # Neovim config
stow -t ~ ghostty   # Ghostty terminal config
stow -t ~ zsh       # Zsh + Starship config
```

This creates symlinks from `~/.config/*` to the files in this repo.

## Available Configurations

### Ghostty (`ghostty/`)

Modern GPU-accelerated terminal with:
- JetBrains Mono font
- Catppuccin Mocha theme
- macOS-native features (option-as-alt, tabs)
- Quick terminal toggle: `Cmd+`` (backtick)

### Zsh (`zsh/`)

Clean zsh config with:
- [Starship](https://starship.rs/) prompt (fast, minimal, informative)
- Syntax highlighting and autosuggestions
- Smart history (shared, deduplicated)
- Useful aliases (git, navigation)

**Prompt shows:** directory, git branch/status, language versions (when relevant), command duration

### mise (`mise/`)

Universal version manager for dev tools:
- **Node.js** (LTS) + pnpm
- **Ruby** (latest)
- **Python** (latest)

Auto-installs correct versions when entering project directories.

```bash
mise list              # Show installed versions
mise use node@20       # Switch Node version
mise install           # Install versions from .mise.toml
```

### Neovim (`nvim/`)

Minimal neovim setup with:
- [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager (auto-installs on first run)
- Sensible defaults (line numbers, indentation, search, etc.)
- Essential keybindings (space as leader, window navigation)

**First launch:** lazy.nvim will auto-install. Run `:Lazy` to see the plugin manager.

**Key bindings:**
- `<Space>` - Leader key
- `<Esc>` - Clear search highlight
- `<C-h/j/k/l>` - Window navigation
- `<leader>w` - Quick save

## Uninstall

To remove symlinks:

```bash
cd ~/repos/dotfiles
stow -D -t ~ nvim ghostty zsh mise
```
