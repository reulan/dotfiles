# dotfiles

the dotfiles of mpmsimo

Will configure a Macbook or a Ubuntu machine in slightly varying ways. At a glance, you will have the following tools customized for whatever OS the script is run on:
- text editor configuration
- window manager configuration 
- vim configuration
- hotkey configuration

## Usage
### vim
I use vim day-to-day for most of my file editing, bascially anything that's not monolith or microservice with many many moving parts.

Within the .vimrc, I support:
* PEP 8 Python syntax configuration
* Folding

#### Plugin management via `vim-plug`:
* fzf (ctrl+r, never felt so good)
* vim-terraform - Terraform syntax highlighting and auto formatting
* jedi-vim - Python auto completion from within vim

### atom 
Atom is my to-go-to for work I do outside of Python/Bash.

Plugins
* autocomplete-python
* go-plus
* language-hcl
* vim-mode-plus (use vim keybindings everywhere!)

### zsh
I practially still am on training wheels with oh-my-zsh.
* ZSH theme coming soon?

### window manager
chunkwm

### Terminal
kitty

### Keybindings
* kitty (shift+ctrl)
* khd (shift+alt, alt, ctrl+alt)
* vim (leader, and vim specifics)

## Installation
The setup script is intended to be used when a new system is being installed. The script is unfortunately not idempotent for Ubuntu but it's getting there.

If the machine is already bootstrapped, and you only want to configure the dotfiles the link.sh script can be run.

### Macbook
1. Run `setup.sh` this will do a system kernel check and if you are using `darwin` it will:
* symlink dotfiles (`link.sh`)
* invoke the Brewfile and install the applications listed (`brew bundle`)

## Colorscheme
Use the script `colorschemes.sh` to get an output of the 0-15 colors used by kitty.
ZSH theme to come.
vim theme to come - jellybeans is just so good though!?
