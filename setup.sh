#!/bin/bash
#setup.sh
#Date created: 04/04/2016
#Author: mpmsimo

DOTFILE_ARRAY=('.vimrc' '.zshrc' '.gitconfig' 'venv.sh' '.gitconfig.local' 'tmux.conf' 'Brewfile')

install_ubuntu() {
    # Install Ubuntu development packages
    echo "Ubuntu or apt based systems"

    # i3 WM repos
    echo "deb http://debian.sur5r.net/i3/ $(lsb_release -c -s) universe" >> /etc/apt/sources.list
    sudo apt-get update
    # TODO: Unsecure!!! Fix this later.
    sudo apt-get --allow-unauthenticated install sur5r-keyring

    # feh
    sudo apt-get install feh -y

    # Python related stuff, should trim down later.
    sudo apt-get install python-dev python3-dev python-pip vim wget i3 -y
    sudo apt get install build-essential libz-dev libreadline-dev libncursesw5-dev libssl-dev libgdbm-dev libsqlite3-dev libbz2-dev libc6-dev -y
    #libreadline5-dev #Find difference between base and 5

    # Python 3.2 +
    sudo apt-get install liblzma-dev -y

    # Optional
    sudo apt-get install tk-dev libdb-dev -y

    # ZSH via package manager
    echo "Install zsh package"
    sudo apt-get install zsh -y
}

install_centos() {
    # Install CentOS development packages
    echo "CentOS or yum based based systems"
    sudo yum update
    sudo yum install python-devel python-pip vim wget
    sudo yum groupinstall "Development tools" -y
    sudo yum install zlib-devel bzip2-devel openssl-devel ncurses-devel -y
    sudo yum install libxml2-devel libxslt-devel sqlite sqlite-devel  # -y
    #yum -y install mysql-devel  #Since I use PyMSQL - it's not really needed

    # ZSH via package manager
    echo "Install zsh package"
    sudo yum install zsh -y
}

install_mac(){
    # Install brew package manager
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # Install Homebrew tap for brewfile usage
    brew tap Homebrew/bundle
    cd ~/dotfiles
    brew bundle
}

install_zsh(){
    # Install ZSH addons
    wget https://raw.github.com/trapd00r/LS_COLORS/master/LS_COLORS -O
    $HOME/.dircolors
    echo 'eval $(dircolors -b $HOME/.dircolors)' >> $HOME/.bashrc
    cd ~
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
}

install_oh_my_zsh(){
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

install_python(){
    PY2_V="2.7.13" # Install Python 2.7.13 - Last updated: 2016-12-17
    PY3_V="3.6.0" # Install Python 3.6.0- Last updated: 2016-12-23
    while true
    do
        echo "Which version of Python would you like to install?"
        echo "1. $PY2_V"
        echo "2. $PY3_V"
        echo "0. Quit"

        read -p "Which option would you like to select? > " version
        case $version in
            1 ) PY_V=$PY2_V; break;;
            2 ) PY_V=$PY3_V; break;;
            0 ) break;;
            * ) echo ""; echo "Please choose a valid option";;
        esac
    done
    PY_URL="https://www.python.org/ftp/python/$PY_V/Python-$PY_V.tgz"
    echo ""; echo "Installing python $PY_V".
    cd $HOME/dev
    wget --no-check-certificate $PY_URL
    tar zxvf "Python-"$PY_V".tgz"
    cd $HOME/dev/"Python-$PY_V"
    sudo ./configure --prefix=/usr/local
    sudo make
    sudo make altinstall
}

install_vim_plug(){
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_baseos(){
    if [[ $OSTYPE == 'linux-gnu' ]]
        then
            if [[ $(grep -i "id=ubuntu" /etc/*release) == *"ubuntu"* ]]
            then
                echo ""
                install_ubuntu
            elif [[ $(grep -i "centos" /etc/*release) == *"CentOS"* ]]
            then
                install_centos
            fi
    install_python
    install_zsh
        echo "Packages have been installed."
    elif [[ $OSTYPE == "darwin"* ]]
    then
    install_mac
    else
        echo "Operating system "$OSTYPE" is not supported."
    fi
}

install_baseos
#install_pip_packages
#install_oh_my_zsh
bash ./link.sh
install_vim_plug
