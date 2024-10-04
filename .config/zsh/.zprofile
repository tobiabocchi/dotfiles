# vim: set ft=sh :

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Load secrets for login shells
if [[ -f ../dotfiles-secret/secret-zshrc ]]; then
  source ../dotfiles-secret/secret-zshrc
fi
