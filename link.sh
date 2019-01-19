#!/usr/bin/bash
#link.sh - symbolic link and copy stuff over

#echo "${purple}Setting default text editor to vim"
#echo -e "${rnl}"

DOTFILE_ARRAY=('.vimrc' '.zshrc' '.gitconfig' 'venv.sh' 'Brewfile' '.khdrc' '.chunkwmrc' '.sshrc')

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
    KITTY_CONFIGS=('kitty.conf' 'colorscheme.conf')
    KITTY_PATH="$HOME/.config/kitty/"
    mkdir -p $KITTY_PATH

    for file in ${KITTY_CONFIGS[@]};
    do
        echo "Symlinking $file to $KITTY_PATH"
        ln -sfn $HOME/dotfiles/kitty/$file $KITTY_PATH
    done
    
    # chunkwm
    chmod +x ~/.chunkwmrc

    # Moving folders one by one
    echo "Moving .vim to home directory"
    cp -r $HOME/dotfiles/.vim $HOME

    install_sshrc
}

install_sshrc(){
    # sshrc
    echo -e "\nConfiguring sshrc."
    mkdir -p ~/.sshrc.d/.vim

    echo "Moving .vim to sshrc.d directory."
    cp -r $HOME/dotfiles/.vim $HOME/.sshrc.d

    echo "Moving files to sshrc.d directory."
    ln -s ~/.vimrc_sshrc ~/.sshrc.d/.vim/.vimrc
    ln -s ~/.zshrc ~/.sshrc.d/.zshrc
}

install_dotfiles
