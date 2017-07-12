#!/usr/bin/bash
#link.sh - symbolic link and copy stuff over

DOTFILE_ARRAY=('.vimrc' '.zshrc' '.gitconfig' 'venv.sh' '.gitconfig.local' 'tmux.conf' 'Brewfile' '.khdrc' '.chunkwmrc')

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

    # Moving folders one by one
    echo "Moving .vim to home directory"
    cp -r $HOME/dotfiles/.vim $HOME

    echo "Moving .i3 to home directory"
    cp -r $HOME/dotfiles/.i3 $HOME

    echo "Copying .fonts to home directory"
    cp -r $HOME/dotfiles/.fonts $HOME

    echo "Copying .chunkwm to home directory"
    cp -r $HOME/dotfiles/.chunkwm $HOME

    chmod +x ~/.chunkwmrc
}

install_dotfiles
