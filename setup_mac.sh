#!/bin/bash
#setup.sh
#Date created: 04/04/2016
#Author: mpmsimo

install_mac(){
    # Install brew package manager
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # Install Homebrew tap for brewfile usage
    brew tap Homebrew/bundle
    cd ~/dotfiles
    brew bundle
    brew services start khd
    brew services start chunkwm

    # Install Vim
    curl --insecure -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim
    install_zsh
    install_pip_packages
}

install_zsh(){
    # Install ZSH addons
    wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O
    $HOME/.dircolors
    echo 'eval $(dircolors -b $HOME/.dircolors)' >> $HOME/.bashrc
    cd ~
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

    # Install Oh My ZSH
    echo "Installing Oh My ZSH!"
    cd $HOME
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    echo "Making ZSH the default shell (restart will be required)"
    chsh -s "$(which zsh)" # Make ZSH default shell
    echo "ZSH version is $(zsh --version)." # Check verison
}

install_pip_packages(){
    # Install Python packages
    sudo pip install --upgrade pip
    sudo pip install virtualenv
    cd $HOME
    virtualenv env
    source ~/env/bin/activate
    pip install powerline-status
}

install_mac
sudo bash ./link.sh
