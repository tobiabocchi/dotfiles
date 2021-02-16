#[[ -f ~/.zshrc ]] && . ~/.zshrc

export PATH=$PATH:$HOME/.scripts
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="brave"

# Start i3 on login
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx
fi
