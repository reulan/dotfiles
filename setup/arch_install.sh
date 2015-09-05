# For the next Arch Linux install, get these essential packages.
pacman -S openssh

# Install login manager
pacman -S slim archlinux-themes-slim
sudo systemctl enable slim.service

# Install packages associated with xmonad and others to allow to customize the xmonad tiling manager.
sudo pacman -S xmonad xmonad-contrib xmobar xmonad-config trayer dmenu cabal-install
cabal update
cabal install yeganesh

# Install screenshot package
sudo pacman -S scrot

# Packages needed so I can look at the screen comfortably, a display driver may be needed as well.
#pacman -S xorg-server xorg-xinit 

# Packages for tools and applications
pacman -S git vim

# Python Development
pacman -S python python2 python-pip
