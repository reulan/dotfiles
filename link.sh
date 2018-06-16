#!/usr/bin/bash
#link.sh - symbolic link and copy stuff over

DOTFILE_ARRAY=('.vimrc' '.zshrc' '.gitconfig' 'venv.sh' 'Brewfile' '.khdrc' '.chunkwmrc')

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

    # Snowflake kitty
    KITTY_PATH="$HOME/.config/kitty/"
    mkdir -p $KITTY_PATH
    echo "Symlinking kitty.conf to $KITTY_PATH"
    ln -sfn $HOME/dotfiles/kitty.conf $KITTY_PATH
    
    # Snowflake kitty
    CHUNKWM_PLUGIN_PATH="$HOME/.chunkwm_plugins/"
    mkdir -p $CHUNKWM_PLUGIN_PATH
    echo "Symlinking .so files to $CHUNKWM_PLUGIN_PATH"
    ln -sfn $HOME/dotfiles/kitty.conf $CHUNKWM_PLUGIN_PATH


    chmod +x ~/.chunkwmrc

    # Moving folders one by one
    echo "Moving .vim to home directory"
    cp -r $HOME/dotfiles/.vim $HOME

    # Should be ubuntu only
    echo "Moving .i3 to home directory"
    cp -r $HOME/dotfiles/.i3 $HOME
}

install_dotfiles
