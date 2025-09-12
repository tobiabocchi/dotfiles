# vim: set ft=sh :

# Create zsh dir for its data
if [[ ! -d $XDG_DATA_HOME/zsh ]]; then
  mkdir -p "$XDG_DATA_HOME"/zsh
fi

# Helper function to check if a command exists
cmd_exists() { whence "$1" >/dev/null 2>&1; }

# Helper function to check if completion already exists
completion_exists() {
  whence -w "_$1" >/dev/null 2>&1 || grep -q "_$1" "${XDG_DATA_HOME}/zsh/zcompdump" 2>/dev/null
}

if cmd_exists brew; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
fi

# completion
autoload -U compinit
compinit -d "$XDG_DATA_HOME/zsh/zcompdump"
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

# command-specific setups

# aws
if cmd_exists aws; then
  autoload bashcompinit && bashcompinit
  complete -C "$(which aws_completer)" aws
fi

# fzf
if cmd_exists fzf && ! completion_exists fzf; then
  eval "$(fzf --zsh)"
fi

# helm
if cmd_exists helm && ! completion_exists helm; then
  eval "$(helm completion zsh)"
fi

# hugo
if cmd_exists hugo && ! completion_exists hugo; then
  eval "$(hugo completion zsh)"
fi

# kubectl
if cmd_exists kubectl; then
  if ! completion_exists kubectl; then
    eval "$(kubectl completion zsh)"
  fi
  if cmd_exists kubecolor; then
    # Make "kubecolor" borrow the same completion logic as "kubectl"
    compdef kubecolor=kubectl
  fi
fi

# kubectl-krew
if cmd_exists kubctl-krew; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# mise
if cmd_exists mise; then
  if ! completion_exists mise; then
    eval "$(mise completion zsh)"
  fi
  eval "$(mise activate zsh)"
fi

# pluto
if cmd_exists pluto && ! completion_exists pluto; then
  eval "$(pluto completion zsh --no-footer)"
fi

# pyenv
if [[ -f $HOME/.pyenv ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# starship, install if missing
if ! cmd_exists starship; then
  curl -sS https://starship.rs/install.sh | sh
fi

if cmd_exists starship; then
  eval "$(starship init zsh)"
fi

# stern
if cmd_exists stern && ! completion_exists stern; then
  eval "$(stern --completion zsh)"
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

# zoxide
if cmd_exists zoxide; then
  export _ZO_DATA_DIR=$XDG_DATA_HOME
  eval "$(zoxide init zsh)"
  alias cd=z
fi

# zsh-users plugins
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search zsh-completions)
for plugin in "${plugins[@]}"; do
  if [[ ! -d "$XDG_DATA_HOME/zsh/$plugin" ]]; then
    git clone "https://github.com/zsh-users/${plugin}.git" "$XDG_DATA_HOME/zsh/$plugin"
  fi
  # skip zsh-completions, it's already loaded by compinit
  if [[ $plugin == "zsh-completions" ]]; then
    fpath=("$XDG_DATA_HOME/zsh/$plugin/src" $fpath)
    continue
  fi
  source "$XDG_DATA_HOME/zsh/$plugin/$plugin.zsh"
done

# other plugins
# if [[ ! -d $XDG_DATA_HOME/zsh/zsh-vi-mode ]]; then
#   git clone "https://github.com/jeffreytse/zsh-vi-mode.git" "$XDG_DATA_HOME/zsh/zsh-vi-mode"
# fi
# source "$XDG_DATA_HOME/zsh/zsh-vi-mode/zsh-vi-mode.zsh"

# history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export HISTSIZE=1000000
export SAVEHIST=1000000
# needed for vimtex-neovim
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
# pretty man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Keybindings
bindkey -v # Use vim keybindings
bindkey "^y" autosuggest-accept
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'i' history-substring-search-up
bindkey -M vicmd 'e' history-substring-search-down

# aliases
alias ...="cd ../.."
alias ..="cd .."

alias g="git"
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gd="git diff"
alias gl="git log"
alias gp="git push"
alias gs="git status"

alias h='history -t "%d.%m.%y-%H:%M:%S"'
alias k='kubecolor'

alias l="ls -l"
alias la="ls -a"
alias ll="ls -l"
alias ls="ls -Gh"

alias p3="python3"
alias st='speedtest-cli'
alias v="nvim"
