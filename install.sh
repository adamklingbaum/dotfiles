#! /bin/bash

set -e

current_status() {
  printf "\e[33m⭑\e[0m %s\n" "$1"
}

link_file() {
  local src=$1 dst=$2
  mkdir -p "$(dirname "$dst")"
  if [ -d "$src" ]; then
    ln -sfn "$src" "$dst"
  else
    ln -sf "$src" "$dst"
  fi
}

if [ $SPIN ]; then
  current_status "Installing packages"
  sudo apt-get install -y neovim ripgrep
fi

current_status "Installing ohmyzsh"
if [ -d ~/.oh-my-zsh ]; then
  current_status "Found ~/.oh-my-zsh - skipping this step"
else
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

current_status "Installing dotfiles"

dotfiles=(.zshrc)

for file in "${dotfiles[@]}"
do
  current_status "Linking ${file}"
  rm -f ~/$file
  link_file ~/dotfiles/$file ~/$file
done

if [[ "$OSTYPE" == "darwin"* ]]; then
  if ! which brew > /dev/null; then
    current_status "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi;

  eval "$(/opt/homebrew/bin/brew shellenv)"

  current_status "Installing via brew"
  brew install -q neovim

  brew install --cask font-fira-code-nerd-font
fi

current_status "Linking .vim directory"

mkdir -p ~/.vim
mkdir -p ~/.vim/tmp

current_status "Setting up Neovim config"

link_nvim_config() {
  local src_dir="$HOME/dotfiles/.config/nvim"
  local dst_dir="$HOME/.config/nvim"

  find "$src_dir" -type d | while read -r dir; do
    local rel_path="${dir#$src_dir/}"
    mkdir -p "$dst_dir/$rel_path"
  done

  find "$src_dir" -type f | while read -r file; do
    local rel_path="${file#$src_dir/}"
    link_file "$file" "$dst_dir/$rel_path"
  done
}

current_status "Setting up Neovim config"
link_nvim_config

current_status "Installing lazy.nvim for neovim"

nvim --headless "+Lazy! sync" +qa

current_status "Installation successful 🚀"
