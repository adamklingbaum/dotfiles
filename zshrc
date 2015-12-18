# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source $HOME/.env.local

LANG=en_US.UTF-8

alias bx="bundle exec"
alias dn="cd ~/Dropbox/notes"
alias dnv="cd ~/Dropbox/notes && vim"
alias todo="vim ~/Dropbox/todo/gtd.md"
alias v="vim"
alias vim-swp-clear="rm -rf ~/.tmp/*.swp"

alias vim="stty stop '' -ixoff ; mvim -v" # Allow vim to accept Ctrl+S
ttyctl -f                                 # `Frozing' tty, so after any command terminal settings will be restored

ssh-add &>/dev/null

export PATH=$PATH:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/X11/bin:/usr/local/git/bin
export PATH=/usr/local/bin:$PATH
export PATH=~/.bin:$PATH

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export EDITOR=vim

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"

export DOCKER_HOST=tcp://$(boot2docker ip 2>/dev/null):2376
export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
