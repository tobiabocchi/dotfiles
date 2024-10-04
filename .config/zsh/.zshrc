# vim: set ft=sh :

# completion
autoload -U compinit
compinit
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

# command-specific setups

# fzf
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
else
  echo "fzf not found"
fi

# kubectl
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

# pyenv
if [[ -f $HOME/.pyenv ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# tmux
if [[ -n $TMUX ]]; then
  export TERM="tmux-256color"
fi

# zsh plugins
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)
if [[ ! -d $XDG_DATA_HOME/zsh ]]; then # create a dir to store plugins
  mkdir -p "$XDG_DATA_HOME"/zsh
fi
for plugin in $plugins; do
  if [[ ! -d $XDG_DATA_HOME/zsh/$plugin ]]; then
    git clone "https://github.com/zsh-users/$plugin.git $XDG_DATA_HOME/zsh/$plugin"
  fi
  source "$XDG_DATA_HOME/zsh/$plugin/$plugin.zsh"
done

# history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
export HISTSIZE=100000
# needed for vimtex-neovim
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
# pretty man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Keybindings
bindkey -v # Use vim keybindings
bindkey "^y" autosuggest-accept
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# aliases
alias v="nvim"
alias ls="ls -Gh"
alias ll="ls -l"
alias l="ls -l"
alias la="ls -a"
alias ..="cd .."
alias ...="cd ../.."
alias g="git"
alias gs="git status"
alias gl="git log"
alias gd="git diff"
alias gc="git commit"
alias gb="git branch"
alias ga="git add"
alias gp="git push"
alias p3="python3"
alias h='history -t "%d.%m.%y-%H:%M:%S"'
alias st='speedtest-cli'
alias k='kubectl'

eval "$(starship init zsh)"
