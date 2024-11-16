# vim: set ft=sh :

# Create zsh dir for its data
if [[ ! -d $XDG_DATA_HOME/zsh ]]; then
  mkdir -p "$XDG_DATA_HOME"/zsh
fi

# completion
autoload -U compinit
compinit -d "$XDG_DATA_HOME/zsh/zcompdump"
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

# command-specific setups

# aws
if command -v aws >/dev/null 2>&1; then
  autoload bashcompinit && bashcompinit
  complete -C "$(which aws_completer)" aws
fi

# direnv
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
else
  echo "fzf not found"
fi

if command -v helm >/dev/null 2>&1; then
  source <(helm completion zsh)
fi

# kubectl
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  if command -v kubecolor >/dev/null 2>&1; then
    # Make "kubecolor" borrow the same completion logic as "kubectl"
    compdef kubecolor=kubectl
  fi
fi

# pyenv
if [[ -f $HOME/.pyenv ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# tmux
export TMUX_PLUGIN_MANAGER_PATH=$XDG_DATA_HOME/tmux/plugins
# Create tmux dir for its data (plugins)
if [[ ! -d $XDG_DATA_HOME/tmux/plugins ]]; then
  mkdir -p "$XDG_DATA_HOME"/tmux/plugins
fi

if [[ -n $TMUX ]]; then
  export TERM="tmux-256color"
fi

# zsh plugins
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)
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
export HISTFILE="$XDG_DATA_HOME/zsh/history"
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
alias k='kubecolor'

eval "$(starship init zsh)"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
