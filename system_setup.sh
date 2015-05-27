# Install packages
echo "Installing pip, git, tmux, vim and zsh packages"
sudo apt-get install vim zsh python-pip git tmux

# Install pip packages
echo "Installing virtualenv, powerline and git-review pip packages"
sudo pip install virtualenv powerline-status git-review

# Check verison
echo "Checking zsh version..."
zsh --version

echo "Installing Oh My ZSH!"
cd ~
wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

# Make ZSH default shell
echo "Making ZSH the default shell"
chsh -s $(chsh -l | grep "zsh" -m 1)

echo "Current shell is: $SHELL"

. ~/dotfiles/setup_dotfiles.sh
