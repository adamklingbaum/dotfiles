# Bash configuration
# Minimal config for non-interactive shells (Cursor, scripts, etc.)

# ----- Homebrew -----
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ----- mise (version manager) -----
# Manages Node, Ruby, Python, etc.
if command -v mise &>/dev/null; then
  eval "$(mise activate bash)"
fi

. "$HOME/.local/bin/env"
