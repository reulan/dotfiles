# dotfiles

mpmsimo's personal dotfiles.

Will configure a Macbook or a Ubuntu machine in slightly varying ways. At a glance, you will have the following tools customized for whatever OS the script is run on:
- text editor configuration
- window manager configuration 
- terminal multiplexer

## Usage
### vim
I use vim day-to-day for most of my file editing, bascially anything that's not monolith or microservice with many many moving parts.

Within the .vimrc, I support:
* PEP 8 Python syntax configuration
* Folding

 Plugin management via `vim-plug`:
** fzf (ctrl+r, never felt so good)
** vim-terraform
** vim-airline

### atom 
Atom is my to-go-to for work I do outside of Python/Bash.

Plugins
* autocomplete-python
* go-plus
* language-hcl
* vim-mode-plus (use vim keybindings everywhere!)

### zsh
I practially still am on training wheels with oh-my-zsh.

### window manager
i3 - ubuntu
chunkwm + khd - Macbook

### Terminal
iterm2
kitty

## Installation
The setup script is intended to be used when a new system is being installed. The script is unfortunately not idempotent for Ubuntu but it's getting there.

### Ubuntu (Experimental)
1. Run `setup.sh` this will do a system kernel check and if you are using `darwin`.
2. Installs `nvim`, `oni`, and `i3` tools that I don't use day to day so the setup might be wonky.

### Macbook
1. Run `setup.sh` this will do a system kernel check and if you are using `darwin` it will:
* symlink dotfiles (`link.sh`)
* invoke the Brewfile and install the applications listed (`brew bundle`)
