# Install zsh from package manger

# Check verison
zsh --version

# Make ZSH default shell
chsh -s $(chsh -l | grep "zsh" -m 1)
