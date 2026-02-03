# Bash profile - sources .bashrc for consistency
# On macOS, login shells read .bash_profile, not .bashrc

if [[ -f "$HOME/.bashrc" ]]; then
  source "$HOME/.bashrc"
fi
