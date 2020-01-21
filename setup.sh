#!/bin/bash
#setup.sh
#Author: mpmsimo

# Set preferred defaults if running on new system
export VISUAL=vim
export EDITOR="$VISUAL"

# Define hardcoded expected paths.
DOTFILE_PATH="$HOME/dotfiles"
CONFIG_PATH="$HOME/.config"
TMP="/tmp"

# Define files that will need to be transferred.
DOTFILE_ARRAY=('.vimrc' '.zshrc' '.gitconfig' 'Brewfile' '.skhdrc') 
KITTY_CONFIGS=('kitty.conf' 'colorscheme.conf' 'keybindings.conf')
YABAI_CONFIGS=('.yabairc')
TMP="/tmp"

# Colorize text
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
purple=`tput setaf 5`

reset=`tput sgr0`
rnl="${reset}\n"

### System installation functions
install_python(){
    echo -e "${yellow}Installing Python tools${rnl}\n"

    sudo pip install --upgrade pip
    sudo pip install virtualenv

    cd $HOME
    virtualenv env
    source ~/env/bin/activate
}

install_vim(){
    echo "Moving .vim to home directory"
    cp -r $DOTFILE_PATH/.vim $HOME

    # vim-plug
    echo -e "${yellow}Installing vim-plug${rnl}".
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_zsh(){
    echo -e "${yellow}Installing oh-my-zsh${rnl}\n"

    # Install newest
    if [ ! -d "$HOME/.oh-my.zsh" ]; then
        cd /tmp
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

        # Change default shell
        cd $HOME
        chsh -s /bin/zsh $USER # Make ZSH default shell
        echo -e "${purple} ZSH version is $(zsh --version). ${rnl}" 
    fi
}

# minimal install for Mac
install_mac(){
	if [[ $OSTYPE == "darwin"* ]]; then
		echo -e "${red}Please enter your SSH passphrase so ZSH and vim-plug can be installed later: ${rnl}"
		ssh-add
		echo -e "${green}Packages have been installed.${rnl}"
	else
		echo -e "${red}Operating system "$OSTYPE" is not supported.${rnl}"
		exit 1
	fi

    echo -e "${blue}Installing MacOS settings${rnl}\n"

    # Install Homebrew,
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap Homebrew/bundle

    # Locate the Brewfile and execute it.
    brew bundle --file=~/dotfiles/Brewfile
 
    # Perform post-brewfile configuration
    #install_python # move to pipenv
    install_vim # requires .vim to be moved over ideally.
    install_zsh # install oh-my-zsh

    # Perform a symbolic link to reference dotfiles from the repo to the $HOME dir.
    install_dotfiles

    # Enable window + hotkey manager
    echo -e "${blue}Enabling brew services.${blue}"
    brew services start skhd
    brew services start chunkwm
}

# Configure vim, kitty, chunkwm and move remote configs + directories
install_dotfiles(){
    # Copy dotfiles to home directory
    for DOTFILE in ${DOTFILE_ARRAY[@]};
    do
        echo -e "${purple}Symlinking ($DOTFILE) to [$HOME]${rnl}"
        ln -sfn $HOME/dotfiles/$DOTFILE $HOME
    done

    # kitty
    KITTY_PATH="$CONFIG_PATH/kitty"
    mkdir -p $KITTY_PATH
    for KITTY_CONFIG in ${KITTY_CONFIGS[@]};
    do
        echo -e "${purple}Symlinking ($KITTY_CONFIG) to [$KITTY_PATH]${rnl}"
        ln -sfn $DOTFILE_PATH/kitty/$KITTY_CONFIG $KITTY_PATH/$KITTY_CONFIG 
    done
    
    # yabai
    YABAI_PATH="$CONFIG_PATH/kitty"
    mkdir -p $YABAI_PATH
    echo -e "${purple}Symlinking .yabairc to [$YABAI_PATH]${rnl}"
    ln -sfn $DOTFILE_PATH/.yabairc $YABAI_PATH/.yabairc
    chmod +x $YABAI_PATH/.yabairc
}

echo "What function would you like to perform?"
select INSTALL_OPTIONS in "1. New Macbook" "2. Link Dotfiles" "3. Quit"; do
    case $INSTALL_OPTIONS in
        1 ) install_mac; break;;
		2 ) install_dotfiles; break;;
        3 ) exit;;
    esac
done

source ~/.zshrc
