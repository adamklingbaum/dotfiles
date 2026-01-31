# Zsh configuration

# ----- History -----
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY       # Write timestamp to history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first
setopt HIST_IGNORE_DUPS       # Ignore consecutive duplicates
setopt HIST_IGNORE_SPACE      # Ignore commands starting with space
setopt HIST_VERIFY            # Show command before executing from history
setopt SHARE_HISTORY          # Share history between sessions

# ----- Directory navigation -----
setopt AUTO_CD                # cd by typing directory name
setopt AUTO_PUSHD             # Push directories to stack
setopt PUSHD_IGNORE_DUPS      # No duplicates in dir stack
setopt PUSHD_SILENT           # Don't print stack after pushd/popd

# ----- Completion -----
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ----- Key bindings -----
bindkey -e  # Emacs key bindings
bindkey '^[[A' history-search-backward  # Up arrow
bindkey '^[[B' history-search-forward   # Down arrow
bindkey '^[[H' beginning-of-line        # Home
bindkey '^[[F' end-of-line              # End
bindkey '^[[3~' delete-char             # Delete

# ----- Aliases -----
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'

# Git aliases
alias gs='git status'
alias gd='git diff'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -20'

# Neovim
alias vim='nvim'
alias vi='nvim'

# ----- Path -----
# Homebrew
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
  eval "$(mise activate zsh)"
fi

# ----- Plugins -----
# zsh-autosuggestions (install: brew install zsh-autosuggestions)
if [[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# zsh-syntax-highlighting (install: brew install zsh-syntax-highlighting)
# Must be sourced at the end
if [[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ----- Starship prompt -----
# Must be at the end of .zshrc
eval "$(starship init zsh)"
