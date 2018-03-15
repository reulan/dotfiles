#!/bin/bash
#setup.sh
#Date created: 04/04/2016
#Author: mpmsimo

DOTFILE_ARRAY=('.vimrc' '.zshrc' '.gitconfig' '.gitconfig.local' 'tmux.conf') 

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
    sudo apt-get install curl wget git vim -y

    # vim-plug
    echo -e "${blue}Installing vim-plug ${rnl}".
    mkdir -p ~/.vim/autoload/
    curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim

    ### Experimental

    # i3 WM repos
    #echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list
    #sudo apt-get update
    # TODO: Unsecure!!! Fix this later.
    #sudo apt-get install i3 -y
    #sudo apt-get --allow-unauthenticated install sur5r-keyring

    # feh
    #sudo apt-get install feh -y
}

install_zsh(){
    # ZSH via package manager
    echo -e "${blue}Installing ZSH${rnl}\n"
    sudo apt-get install zsh -y

    # Install Oh My ZSH
    cd $HOME
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    chsh -s "$(which zsh)" # Make ZSH default shell
    echo -e "${purple} ZSH version is $(zsh --version). ${rnl}" 
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

prompt_python(){
    PY2_V="2.7.14" # Install Python 2.7.14
    PY3_V="3.6.4" # Install Python 3.6.4
    while true
    do
        echo "${yellow}Which version of Python would you like to install?"
        echo "1. $PY2_V"
        echo "2. $PY3_V"
        echo -e "0. Skip ${rnl}"

        read -p "Which option would you like to select? > " version
        case $version in
            1 ) PY_V=$PY2_V; install_python;;
            2 ) PY_V=$PY3_V; install_python;;
            0 ) break;;
            * ) echo -e "${red}Please choose a valid option. ${rnl}";;
        esac
    done
}

install_python(){
    # Python related packages 
    sudo apt-get install python-pip -y
    install_pip_packages

    # Install Python dependancies
    if $PY_V=$PY2_V; then
        sudo apt-get install python-dev -y
    elif $PY_V=$PY3_V; then
        sudo apt-get install python3-dev -y
    fi

    # Install Python
    PY_URL="https://www.python.org/ftp/python/$PY_V/Python-$PY_V.tgz"
    echo -e "${blue}Installing Python $PY_V ${rnl}".
    cd $HOME/dev
    wget --no-check-certificate $PY_URL
    tar zxvf "Python-"$PY_V".tgz"
    cd $HOME/dev/"Python-$PY_V"
    sudo ./configure --prefix=/usr/local
    sudo make
    sudo make altinstall
}

install_baseos(){
    if [[ $OSTYPE == 'linux-gnu' ]]
        then
            if [[ $(grep -i "id=ubuntu" /etc/*release) == *"ubuntu"* ]]
            then
                install_ubuntu
            fi
    prompt_python 
    install_zsh
    install_dotfiles
        echo -e "${green}Packages have been installed.${rnl}"
    else
        echo -e "${red}Operating system "$OSTYPE" is not supported.${rnl}"
        exit 1
    fi
}

# Fix this to work with link based on OS
DOTFILE_ARRAY=('.vimrc' '.zshrc' '.gitconfig' 'venv.sh' '.gitconfig.local' 'tmux.conf') 

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

install_baseos
source ~/.zshrc
