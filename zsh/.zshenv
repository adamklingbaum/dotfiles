# Zsh environment - sourced for ALL shell types (interactive, non-interactive, login, non-login)
# This ensures tools like mise work in Cursor, scripts, and other non-interactive contexts

# ----- Homebrew -----
# Must come first so mise is available
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
elif [[ -f /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# ----- mise (version manager) -----
# Use shims for non-interactive shells (faster, no hook overhead)
# The full activation in .zshrc handles interactive features
if [[ -d "$HOME/.local/share/mise/shims" ]]; then
  export PATH="$HOME/.local/share/mise/shims:$PATH"
fi
