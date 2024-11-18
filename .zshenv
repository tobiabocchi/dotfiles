# vim: set ft=sh :

# homebrew env vars
if command -v brew >/dev/null 2>&1; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" # ensure dirs exist

# Change zsh dotfiles location
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Add scripts to PATH
export PATH="${HOME}/.local/bin:${HOME}/bin:$PATH" # Add user scripts to PATH
export PATH="/opt/homebrew/bin:$PATH"              # Let Homebrew precede /usr/bin

# set LOCALE
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# for pyhidra
export GHIDRA_INSTALL_DIR="/opt/homebrew/Caskroom/ghidra/11.0.2-20240326/ghidra_11.0.2_PUBLIC/"
