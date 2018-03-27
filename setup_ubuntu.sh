#!/bin/bash
#setup.sh
#Date created: 04/04/2016
#Author: mpmsimo

DOTFILE_ARRAY=('.vimrc' '.zshrc' '.gitconfig' '.gitconfig.local')
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
install_onivim(){
    echo -e "${blue}Installing onivim${rnl}\n"

    sudo apt-get install libappindicator1 -y
    sudo apt-get install -f -y

    # Install neovim
    sudo apt-get install software-properties-common -y
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt-get update
    sudo apt-get install neovim -y

    OMNI_V="0.3.1"
    cd $TMP
    wget https://github.com/onivim/oni/releases/download/v$OMNI_V/Oni-$OMNI_V-amd64-linux.deb
    sudo dpkg -i Oni-$OMNI_V-amd64-linux.deb
    cd $HOME

    # vim-plug
    #echo -e "${blue}Installing vim-plug ${rnl}".
    #mkdir -p ~/.vim/autoload/
    #curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim
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
    install_i3
    install_python
    install_onivim
    install_zsh
    install_gcloud
    install_dotfiles
        echo -e "${green}Packages have been installed.${rnl}"
    else
        echo -e "${red}Operating system "$OSTYPE" is not supported.${rnl}"
        exit 1
    fi
}

install_dotfiles(){
    # Copy dotfiles to home directory
    echo "${purple}Setting default text editor to vim"
    export VISUAL=vim
    export EDITOR="$VISUAL"

    for file in ${DOTFILE_ARRAY[@]};
    do
        echo "Symlinking $file to $HOME"
        ln -sfn $HOME/dotfiles/$file $HOME
    done

    # Moving folders one by one
    echo "Moving .vim to home directory"
    cp -r $HOME/dotfiles/.vim $HOME

    #echo "Moving .i3 to home directory"
    #cp -r $HOME/dotfiles/.i3 $HOME
    echo -e "${rnl}"
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
