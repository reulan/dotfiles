echo "Setting default text editor to vim"
export VISUAL=vim
export EDITOR="$VISUAL"

echo "Moving .vimrc to home directory"
cp .vimrc ~

echo "Moving .zshrc to home directory"
cp .zshrc ~

echo "Moving .tmux.conf to home directory"
cp .tmux.conf ~

echo "Moving .gitconfig to home directory"
cp .gitconfig ~

echo "Moving .vim to home directory"
cp -r .vim ~

echo "Setup complete"
