#!/bin/bash
echo "Setting default text editor to vim"
export VISUAL=vim
export EDITOR="$VISUAL"

echo "Moving .vimrc to home directory"
cp .vimrc $HOME

echo "Moving .zshrc to home directory"
cp .zshrc $HOME

#echo "Moving .tmux.conf to home directory"
#cp .tmux.conf $HOME

echo "Moving .gitconfig to home directory"
cp .gitconfig $HOME

echo "Moving .vim to home directory"
cp -r .vim $HOME

echo "Setup complete"
