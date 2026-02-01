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

# Git aliases (oh-my-zsh style)
# Status
alias gst='git status'
alias gss='git status -s'

# Add
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'

# Commit
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcam='git commit -a -m'
alias gcmsg='git commit -m'

# Push/Pull
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpf!='git push --force'
alias gpsup='git push --set-upstream origin $(git branch --show-current)'
alias gl='git pull'
alias gpr='git pull --rebase'

# Fetch
alias gf='git fetch'
alias gfa='git fetch --all --prune'

# Branch
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'

# Checkout
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'
alias gcd='git checkout develop'

# Diff
alias gd='git diff'
alias gds='git diff --staged'
alias gdca='git diff --cached'
alias gdt='git diff-tree --no-commit-id --name-only -r'

# Log
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glo='git log --oneline --decorate -20'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'

# Merge
alias gm='git merge'
alias gma='git merge --abort'
alias gms='git merge --squash'

# Rebase
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grba='git rebase --abort'
alias grbs='git rebase --skip'
alias grbm='git rebase $(git_main_branch)'

# Reset
alias grh='git reset'
alias grhh='git reset --hard'
alias grhs='git reset --soft'
alias gru='git reset --'
alias gpristine='git reset --hard && git clean -dffx'

# Stash
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gstc='git stash clear'

# Remote
alias gr='git remote'
alias grv='git remote -v'
alias gra='git remote add'
alias grrm='git remote remove'
alias grset='git remote set-url'

# Cherry-pick
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# Misc
alias gcl='git clone --recurse-submodules'
alias gbl='git blame -b -w'
alias gcf='git config --list'
alias gcount='git shortlog -sn'
alias gclean='git clean -fd'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

# Helper function for main branch detection
git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/heads/{main,master,trunk,mainline,default}; do
    if command git show-ref -q --verify "$ref"; then
      echo "${ref#refs/heads/}"
      return
    fi
  done
  echo "main"
}

# Neovim
alias vim='nvim'
alias vi='nvim'
alias nv='nvim'

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
