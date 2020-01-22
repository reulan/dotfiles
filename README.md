# dotfiles

the dotfiles of mpmsimo

Can configure a Macbook using the `dotfiles.sh` script, installs the following utilities:
- [kitty](https://github.com/kovidgoyal/kitty) | terminal
- [skhd](https://github.com/koekeishiya/skhd) | keybindings
- [vim]() | text editor
- [yabai](https://github.com/koekeishiya/yabai) | window manager

## Text Editor
I use vim day-to-day for most of my file editing, bascially anything that's not monolith or microservice with many many moving parts.

Within the .vimrc, I support:
* PEP 8 Python syntax configuration
* Several colorschemes (jellybeans, preferred)
* various plugins via `vim-plug`
* remove noob mode (arrow keys + mouse)

### Plugin management via `vim-plug`:
* fzf (ctrl+r, never felt so good)
* vim-terraform - Terraform syntax highlighting and auto formatting

See `.vimrc` for the source of truth for the plugins.

## Terminal
I use the ZSH shell which is further enhanced using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).
* Creating a ZSH theme is currently on my to-do list.

## Keybindings
Generally designed around vim style keybindings.
h = left (previous window/desktop)
j = down
k = up
l = right (next window/desktop)

I do believe modifiers should be unique to the application, as this has bit me in the past.

* kitty (ctrl+shift)
* skhd (alt+)
* yabai (ctrl+!shift, cmd+)
* vim (leader, and vim specifics)

## Installation
The setup script is intended to be used when a new system is being installed. 

### Macbook
```
> clone this repo to $HOME
cd ~/dotfiles
bash dotfiles.sh
```

## Colorscheme
Use the script `colorschemes.sh` to get an output of the 0-15 colors used by kitty.

### kitty colorscheme
Can be located in `/kitty/colorscheme.conf`

### vim colorschemes
Can be located in `/.vim/colors`
- jellybeans (preferred)
- molokai (so pretty!)
- dim (dynamic color scheme based on ANSI terminal colors 0-15), see kitty.conf for my hex values.
