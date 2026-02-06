# Git aliases and functions
# Based on Oh My Zsh git plugin with custom additions

# ----- Helper Functions -----

# Check if main exists and use instead of master
function git_main_branch() {
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

# Check if develop branch exists
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel develop development; do
    if command git show-ref -q --verify "refs/heads/$branch"; then
      echo "$branch"
      return
    fi
  done
  echo "develop"
}

# Get current branch name
function git_current_branch() {
  git branch --show-current 2>/dev/null
}

# ----- Git Aliases -----

# Base
alias g='git'

# Add
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gav='git add --verbose'

# Apply
alias gap='git apply'
alias gapt='git apply --3way'

# Bisect
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

# Blame
alias gbl='git blame -w'

# Branch
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '\''{print $1}'\'' | xargs git branch --delete'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '\''{print $1}'\'' | xargs git branch --delete --force'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsc='git branch --show-current'

# Checkout
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcd='git checkout $(git_develop_branch)'
alias gcm='git checkout $(git_main_branch)'
alias gcor='git checkout --recurse-submodules'

# Cherry-pick
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

# Clean
alias gclean='git clean -id'

# Clone
alias gcl='git clone --recurse-submodules'

# Commit
alias gc='git commit --verbose'
alias gc!='git commit --verbose --amend'
alias gcn!='git commit --verbose --no-edit --amend'
alias gca='git commit --verbose --all'
alias gca!='git commit --verbose --all --amend'
alias gcan!='git commit --verbose --all --no-edit --amend'
alias gcans!='git commit --verbose --all --signoff --no-edit --amend'
alias gcam='git commit --all --message'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcs='git commit --gpg-sign'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'
alias gcmsg='git commit --message'
alias gcsm='git commit --signoff --message'

# Config
alias gcf='git config --list'

# Describe
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'

# Diff
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'
alias gdnolock='git diff $@ ":(exclude)package-lock.json" ":(exclude)*.lock"'

function gdv() { git diff -w "$@" | view - }

# Fetch
alias gf='git fetch'
alias gfa='git fetch --all --tags --prune --jobs=10'
alias gfo='git fetch origin'

# GUI
alias gg='git gui citool'
alias gga='git gui citool --amend'

# Gitk
alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log --walk-reflogs --pretty=%h) &!'

# Grep
alias ggpur='ggu'

# Help
alias ghh='git help'

# Ignore
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias gunignore='git update-index --no-assume-unchanged'

# Log
alias gcount='git shortlog --summary --numbered'
alias glg='git log --stat'
alias glgp='git log --stat --patch'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'

# Merge
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gmff='git merge --ff-only'
alias gmom='git merge origin/$(git_main_branch)'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gms='git merge --squash'
alias gmum='git merge upstream/$(git_main_branch)'

# Pull
alias gl='git pull'
alias gpr='git pull --rebase'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash -v'
alias gprom='git pull --rebase origin $(git_main_branch)'
alias gpromi='git pull --rebase=interactive origin $(git_main_branch)'
alias gprum='git pull --rebase upstream $(git_main_branch)'
alias gprumi='git pull --rebase=interactive upstream $(git_main_branch)'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggu='git pull --rebase origin "$(git_current_branch)"'
alias gup='git pull --rebase'
alias gupa='git pull --rebase --autostash'
alias gupav='git pull --rebase --autostash --verbose'
alias gupom='git pull --rebase origin $(git_main_branch)'
alias gupomi='git pull --rebase=interactive origin $(git_main_branch)'
alias gupv='git pull --rebase --verbose'

# Push
alias gp='git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease --force-if-includes'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias ggpush='git push origin "$(git_current_branch)"'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes'
alias gpu='git push upstream'
alias gpv='git push --verbose'

# Rebase
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbo='git rebase --onto'
alias grbs='git rebase --skip'
alias grbd='git rebase $(git_develop_branch)'
alias grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbum='git rebase upstream/$(git_main_branch)'

# Reflog
alias grf='git reflog'

# Remote
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias gru='git remote update'
alias grup='git remote update --prune'
alias grv='git remote --verbose'

# Reset
alias grh='git reset'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias gpristine='git reset --hard && git clean -dffx'
alias groh='git reset origin/$(git_current_branch) --hard'

# Restore
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'

# Revert
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'

# Rm
alias grm='git rm'
alias grmc='git rm --cached'

# Root
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'

# Shortlog
alias gsh='git show'
alias gsps='git show --pretty=short --show-signature'

# Show
alias gshow='git show'

# Stash
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstall='git stash --all'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --patch'

# Status
alias gst='git status'
alias gss='git status --short'
alias gsb='git status --short --branch'

# Submodule
alias gsi='git submodule init'
alias gsu='git submodule update'
alias gsur='git submodule update --recursive'
alias gsuri='git submodule update --recursive --init'

# SVN
alias gsr='git svn rebase'
alias gsd='git svn dcommit'

# Switch
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'

# Tag
alias gta='git tag --annotate'
alias gts='git tag --sign'
alias gtv='git tag | sort -V'

function gtl() {
  git tag --sort=-v:refname -n --list "${1}*"
}

# WIP
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gunwip='git rev-parse --verify --quiet HEAD~1 && git log -n 1 --pretty=format:"%s" | grep -q "\--wip--" && git reset HEAD~1'

# Whatchanged
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'

# Delete merged branches
function gbda() {
  git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch --delete 2>/dev/null
}

# ----- Worktree Aliases -----
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtl='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'
alias gwtrmf='git worktree remove --force'
alias gwtp='git worktree prune'
alias gwtlk='git worktree lock'
alias gwtulk='git worktree unlock'
alias gwtrp='git worktree repair'

# ----- Custom Worktree Functions -----

# Add worktree with new branch: gwtab ../feature-x feature-x
gwtab() {
  git worktree add -b "$2" "$1" "${3:-HEAD}"
}

# Add worktree tracking remote branch: gwtat ../bugfix origin/bugfix-123
gwtat() {
  git worktree add --track -b "${2##*/}" "$1" "$2"
}

# Quick worktree in sibling directory named after branch
# Usage: gwtq feature-branch -> creates ../repo-feature-branch
gwtq() {
  local branch="$1"
  local repo_name=$(basename "$(git rev-parse --show-toplevel)")
  local worktree_path="../${repo_name}-${branch}"
  if git show-ref --verify --quiet "refs/heads/$branch" 2>/dev/null; then
    git worktree add "$worktree_path" "$branch"
  elif git show-ref --verify --quiet "refs/remotes/origin/$branch" 2>/dev/null; then
    git worktree add --track -b "$branch" "$worktree_path" "origin/$branch"
  else
    git worktree add -b "$branch" "$worktree_path"
  fi
  echo "Created worktree at $worktree_path"
}

# List worktrees with condensed output
gwtls() {
  git worktree list --porcelain | awk '/^worktree/ {wt=$2} /^branch/ {gsub("refs/heads/","",$2); print $2 " -> " wt}'
}

# Remove worktree by branch name (searches for matching worktree)
gwtrb() {
  local wt=$(git worktree list --porcelain | awk -v branch="$1" '
    /^worktree/ {wt=$2}
    /^branch/ && $2 ~ branch {print wt; exit}
  ')
  if [[ -n "$wt" ]]; then
    git worktree remove "$wt" && echo "Removed worktree: $wt"
  else
    echo "No worktree found for branch: $1" >&2
    return 1
  fi
}

# ----- Custom Dependabot Functions -----

# Usage: depbot 123 recreate | depbot --dry-run 123 rebase
depbot() {
  local dry_run=false
  if [[ "$1" == "--dry-run" ]]; then
    dry_run=true
    shift
  fi
  if [[ -z "$1" ]]; then
    echo "Usage: depbot [--dry-run] <pr-number> <command>" >&2
    echo "Commands: recreate, rebase, merge, squash, cancel" >&2
    return 1
  fi
  local pr="$1"
  local cmd="${2:-recreate}"
  if $dry_run; then
    echo "Would run: gh pr comment $pr --body \"@dependabot $cmd\""
  else
    gh pr comment "$pr" --body "@dependabot $cmd"
  fi
}

# Shortcuts for common dependabot commands
alias dpr='depbot'
dprecreate() { depbot "$1" recreate; }
dprebase() { depbot "$1" rebase; }
