# dotfiles

the dotfiles of mpmsimo

Can configure a Macbook using the setup.sh script. 
- text editor configuration
- window manager configuration 
- hotkey configuration

## Usage
### vim
I use vim day-to-day for most of my file editing, bascially anything that's not monolith or microservice with many many moving parts.

Within the .vimrc, I support:
* PEP 8 Python syntax configuration
* Folding
* Dim colorscheme based off the colors defined in kitty.conf
* remove noob mode (arrow keys + mouse)
* various plugins via `vim-plug`

#### Plugin management via `vim-plug`:
* fzf (ctrl+r, never felt so good)
* vim-terraform - Terraform syntax highlighting and auto formatting
* jedi-vim - Python auto completion from within vim (can sometimes crash terminal)

### ZSH
I use the ZSH shell which is further enhanced using [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh).
* Creating a ZSH theme is currently on my to-do list.

### Window manager
[chunkwm](https://github.com/koekeishiya/chunkwm)

### Terminal
[kitty](https://github.com/kovidgoyal/kitty)

### Keybindings
* kitty (shift+ctrl)
* khd (shift+alt, alt, ctrl+alt)
* vim (leader, and vim specifics)

## Installation
The setup script is intended to be used when a new system is being installed. 

### Macbook
```
cd ~/dotfiles
> clone this repo
bash setup.sh
```

## Colorscheme
Use the script `colorschemes.sh` to get an output of the 0-15 colors used by kitty.
- jellybeans (preferred)
- molokai (so pretty!)
- dim (dynamic color scheme based on ANSI terminal colors 0-15), see kitty.conf for my hex values.
