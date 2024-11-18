# dotfiles

> Work it harder, make it better
>
> Do it faster, makes us stronger

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="img/cautionary_dark.png">
  <source media="(prefers-color-scheme: light)" srcset="img/cautionary.png">
  <img alt="Work it harder, make it better. Do it faster, makes us stronger." src="img/cautionary.png">
</picture>

To install the dotfiles:

```sh
git clone https://github.com/tobiabocchi/dotfiles
cd dotfiles
mkdir -p ~/.config # Ensure this dir exist so we don't link to it
rm ~/.zshenv # If you care about this file just move it so we can link it
stow . --target=$HOME
# misc dependencies (for testing with alpine container)
# unzip wget gzip python3 ripgrep clang bash zsh git fzf stow curl snapd (for nvim)
```
