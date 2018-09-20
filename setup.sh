#!/bin/bash
#setup.sh
#Date created: 04/04/2016
#Author: mpmsimo

TMP="/tmp"

# Colorize text
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
purple=`tput setaf 5`

reset=`tput sgr0`
rnl="${reset}\n"

echo -e "${purple}Starting $0${reset}"

install_mac(){
    echo -e "${blue}Installing MacOS settings${rnl}\n"
    # Install brew package manager
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # Install Homebrew tap for brewfile usage
    brew tap Homebrew/bundle
    cd ~/dotfiles
    brew bundle
    brew services start khd
    brew services start chunkwm
}

install_ubuntu() {
    # Required packages
    sudo apt-get install curl wget git -y
}

install_zsh(){
    # ZSH via package manager
    echo -e "${blue}Installing ZSH${rnl}\n"
    sudo apt-get install zsh -y

    # Install Oh My ZSH
    cd $TMP
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    cd $HOME
    chsh -s "$(which zsh)" # Make ZSH default shell
    echo -e "${purple} ZSH version is $(zsh --version). ${rnl}" 
}

# Window Manager
install_i3(){
    ### Experimental
    echo -e "${blue}Installing i3${rnl}\n"

    # i3 WM repos
    #echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list
    #sudo apt-get update
    # TODO: Unsecure!!! Fix this later.
    #sudo apt-get install i3 -y
    #sudo apt-get --allow-unauthenticated install sur5r-keyring

    # feh
    #sudo apt-get install feh -y
}

# Vim
install_vim(){
    echo -e "${blue}Installing vim${rnl}\n"

    sudo apt-get install libappindicator1 -y
    sudo apt-get install -f -y

    # vim-plug
    echo -e "${blue}Installing vim-plug ${rnl}".
    mkdir -p ~/.vim/autoload/
    curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim
}

install_python(){
    echo -e "${blue}Installing Python${rnl}\n"

    # Python 2
    sudo apt-get install python-dev python-pip python-dev -y

    # Python 3
    sudo apt-get install python3-dev python3-pip python3-dev -y

    # Neovim
    sudo apt-get install python-neovim python3-neovim -y
}

install_pip_packages(){
    # Install Python packages
    echo -e "${blue}Installing pip packages${rnl}\n"

    sudo pip install --upgrade pip
    sudo pip install virtualenv

    cd $HOME
    virtualenv env
    source ~/env/bin/activate

    pip install powerline-status
}

install_baseos(){
    if [[ $OSTYPE == 'linux-gnu' ]]
        then
            if [[ $(grep -i "id=ubuntu" /etc/*release) == *"ubuntu"* ]]
            then
                install_ubuntu
            fi
    #install_i3
    elif [[ $OSTYPE == "darwin"* ]]
    then
    install_mac
    else
        echo -e "${red}Operating system "$OSTYPE" is not supported.${rnl}"
        exit 1
    fi
    install_niceities
    echo -e "${green}Packages have been installed.${rnl}"
}

install_niceities(){
    install_gcloud
    install_python
    install_vim
    install_zsh
    install_dotfiles
}

install_dotfiles(){
    bash link.sh &
}

install_gcloud(){
    # Create an environment variable for the correct distribution
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

    # Add the Cloud SDK distribution URI as a package source
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

    # Import the Google Cloud Platform public key
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    # Update the package list and install the Cloud SDK
    sudo apt-get update && sudo apt-get install google-cloud-sdk kubectl -y

    gcloud init
}

install_baseos
source ~/.zshrc
