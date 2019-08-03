#!/bin/bash
#link.sh - symbolic link and copy stuff over

#echo "${purple}Setting default text editor to vim"
#echo -e "${rnl}"

# Change this to be dynamically loaded
DOTFILE_ARRAY=('.vimrc' '.zshrc' '.gitconfig' 'Brewfile' '.khdrc' '.chunkwmrc') 

# Configure vim, kitty, chunkwm and move remote configs + directories
install_dotfiles(){
    # Copy dotfiles to home directory
    echo "Setting default text editor to vim"
    export VISUAL=vim
    export EDITOR="$VISUAL"

    for file in ${DOTFILE_ARRAY[@]};
    do
        echo "Symlinking $file to $HOME"
        ln -sfn $HOME/dotfiles/$file $HOME
    done

    # kitty
    KITTY_CONFIGS=('kitty.conf' 'colorscheme.conf' 'keybindings.conf')
    KITTY_PATH="$HOME/.config/kitty/"
    mkdir -p $KITTY_PATH

    for FILE in ${KITTY_CONFIGS[@]};
    do
        echo "Symlinking $FILE to $KITTY_PATH"
        ln -sfn $HOME/dotfiles/kitty/$FILE $KITTY_PATH
    done
    
    # chunkwm
    chmod +x ~/.chunkwmrc

    # Moving folders one by one
    echo "Moving .vim to home directory"
    cp -r $HOME/dotfiles/.vim $HOME

    #install_sshrc
}

install_sshrc(){
    # sshrc
    echo -e "\nConfiguring sshrc."
    mkdir -p ~/.sshrc.d/.vim/colors

    echo "Copying *.vim colorschemes over to .vim/colors."
    cp -r $HOME/dotfiles/.vim/colors/*.vim $HOME/.sshrc.d/.vim/colors

    echo "Moving files to sshrc.d directory."
    ln -s ~/.vimrc_sshrc $HOME/.sshrc.d/.vimrc
    ln -s ~/.zshrc $HOME/.sshrc.d/.zshrc
}

install_dotfiles
