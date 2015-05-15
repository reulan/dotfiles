#!/usr/bin/bash
#sudo apt-get install python-pip
#sudo pip install powerline-status

# Download latest versions of the symbols and config.
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

# Move the file to the fonts directory
mv PowerlineSymbols.otf ~/.fonts/

# Update the font cache
fc-cache -vf ~/.fonts/

# Install the fontconfig file
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
#~/.fonts.conf.d/
