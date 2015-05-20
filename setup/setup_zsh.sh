# Install zsh from package manger
echo "Install zsh package"
# sudo yum install zsh
sudo apt-get install zsh -y

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
