#!/bin/bash
echo "Setting default text editor to vim"
export VISUAL=vim
export EDITOR="$VISUAL"

echo "Moving .vimrc to home directory"
cp $HOME/dotfiles/.vimrc $HOME

echo "Moving .zshrc to home directory"
cp $HOME/dotfiles/.zshrc $HOME

#echo "Moving .tmux.conf to home directory"
#cp $HOME/dotfiles/.tmux.conf $HOME

echo "Moving .gitconfig to home directory"
cp $HOME/dotfiles/.gitconfig $HOME

echo "Moving .vim to home directory"
cp -r $HOME/dotfiles/.vim $HOME

echo "Setup complete"
