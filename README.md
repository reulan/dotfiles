# dotfiles

reulan's dotfiles for bootstrapping the following operating systems:
- MacOS
- PopOS
- Arch Linux

The following utlities are used, some which are shared across all distributions and some which I specificially prefer as a user of the operating system.

Shared:
- [kitty](https://github.com/kovidgoyal/kitty) | terminal emulator
- [nvim](https://www.vim.org/) | command line text editor

MacOS specifc:
- [skhd](https://github.com/koekeishiya/skhd) | keybindings
- [yabai](https://github.com/koekeishiya/yabai) | tiling window manager

PopOS specific:
- [Pop Shell](https://github.com/pop-os/shell) | tiling window manager

Arch Linux specific:
- [i3](https://i3wm.org/) | tiling window manager 

## Overview
### Text Editor
I use vim day-to-day for most of my file editing, bascially anything that's not monolith or microservice with many many moving parts.

Within the .vimrc, I support:
* PEP 8 Python syntax configuration
* (legacy) and nvim (jellybeans, preferred)
* plugin installation via `vim-plug`
* remove noob mode (arrow keys + mouse)
* disable terminal bell
*  custom keybindings

#### Plugin management via `vim-plug`:
* fzf (ctrl+r, never felt so good)
* vim-terraform - Terraform syntax highlighting and auto formatting
* powerline

See `.vimrc` for the source of truth for the plugins.

### Terminal
I use the ZSH shell which is further enhanced using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).

### Keybindings
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

The script will detect your `$OSTYPE`, and then install specific dotfiles depending on the OS.
```
> clone this repo to $HOME
cd ~/dotfiles
bash bootstrap.sh
```

### Other information
## Colorscheme
Use the script `colorschemes.sh` to get an output of the 0-15 colors used by kitty.

### kitty colorscheme
Can be located in `/kitty/colorscheme.conf`

### vim colorschemes
Can be located in `/.vim/colors`
- jellybeans (preferred)
- molokai (so pretty!)
- dim (dynamic color scheme based on ANSI terminal colors 0-15), see kitty.conf for my hex values.

TODO:
* Create a ZSH theme.
