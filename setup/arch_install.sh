# For the next Arch Linux install, get these essential packages.
sudo pacman -S openssh

# Install login manager
sudo pacman -S slim archlinux-themes-slim
sudo systemctl enable slim.service

# Install compositing window manager
sudo pacman -S xcompmgr

# Install packages associated with xmonad and others to allow to customize the xmonad tiling manager.
sudo pacman -S xmonad xmonad-contrib xmobar stalonetray dmenu cabal-install 
sudo cabal update
cabal install --global yeganesh

# Install screenshot package
sudo pacman -S scrot

# Packages needed so I can look at the screen comfortably, a display driver may be needed as well.
#pacman -S xorg-server xorg-xinit 

# Packages for tools and applications
pacman -S git vim

# Python Development
pacman -S python python2 python-pip
