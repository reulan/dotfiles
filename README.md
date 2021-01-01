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
- [yay](https://github.com/Jguer/yay) | AUR package manager (`yay -G $AUR_PKG`)

## Overview
### vim
I use vim day-to-day for most of my file editing, bascially anything that's not monolith or microservice with many many moving parts.

Within the .vimrc, I support:
* PEP 8 Python syntax configuration
* nvim
* color schemes (jellybeans, preferred)
* plugin installation via `vim-plug`
* remove noob mode (arrow keys + mouse)
* disable terminal bell
* custom keybindings (for plugins, leader and vim functions)

#### Plugin management via `vim-plug`:
* fzf (ctrl+r, never felt so good)
* vim-terraform - Terraform syntax highlighting and auto formatting

See `.vimrc` / `init.vim` for the source of truth for the plugins.

#### deoplete
Needs Python3 and some additional software installed:
https://github.com/Shougo/deoplete.nvim

### emacs
I use a preconfigured bundle for emacs called [Doom Emacs](https://github.com/hlissner/doom-emacs).

#### Installation (prereqs)
```
echo "$PATH:$HOME/.emacs.d/bin"
cd ~/kit/pkg
yay -G libgccjit
yay - G emacs-native-comp-git

cd libgccjit
makepkg
cd src/libgccjit-build
make
??? What afterwards?

# emacs speedup + performance
cd emacs-native-comp-git
makepkg
```
See `install_emacs` function of `bootstrap.sh`.

```
SPC-
  -gg
ALT-
CTL-
```

#### Doom
If binary is not in $PATH:
`export PATH="$PATH:$HOME/.emacs.d/bin/`.
```

doom sync
doom doctor
```

### Terminal
I use the ZSH shell which is further enhanced using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).

### Development Workflow
#### Golang
- [ale](https://github.com/dense-analysis/ale)
- [gopls](https://github.com/golang/tools/blob/master/gopls/README.md)

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
