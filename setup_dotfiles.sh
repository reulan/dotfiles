echo "Setting default text editor to vim"
export VISUAL=vim
export EDITOR="$VISUAL"

echo "Moving .vimrc to home directory"
cp .vimrc ~

echo "Moving .vim to home directory"
cp -r .vim ~

echo "Moving .zshrc to home directory"
cp .zshrc ~

echo "Setup complete"
