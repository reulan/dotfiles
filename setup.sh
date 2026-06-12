#!/bin/bash
# Bootstrap for Mac or certain distros of Linux.
# Set preferred defaults if running on new system
export VISUAL=vim
export EDITOR="$VISUAL"

# Define hardcoded expected paths.
DOTFILE_PATH="${HOME}/dotfiles"
SHARED_PATH="${DOTFILE_PATH}/shared"
SHARED_DOTFILES=('.zshrc' '.gitconfig' '.dotenv' '.vimrc')
KITTY_PATH="${HOME}/.config/kitty"
KITTY_CONFIGS=('kitty.conf' 'keybindings.conf' 'baseColorscheme.conf' 'enbyColorscheme.conf' 'jellybeansColorscheme.conf')

# =========================================
# Script output colorization
# =========================================
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
purple=`tput setaf 5`
setaf6=`tput setaf 6`
setaf7=`tput setaf 7`
reset=`tput sgr0`
rnl="${reset}\n"

configure_dotfiles(){
  # Symbolic link shared dotfiles to home directory
  for DOTFILE in ${SHARED_DOTFILES[@]};
  do
    echo -e "${purple}Symlinking ($DOTFILE) to [${HOME}/$DOTFILE].${rnl}"
    ln -sfFn ${SHARED_PATH}/${DOTFILE} ${HOME}
  done
}

install_oh_my_zsh(){
  echo -e "${yellow}Installing oh-my-zsh.${rnl}\n"

  # Install, if oh-my-zsh config doesn't exist
  if [ ! -d "${HOME}/.oh-my.zsh" ]; then
    cd /tmp
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Change default shell
    cd ${HOME}
    chsh -s "/bin/zsh" ${USER}
    echo -e "${purple} ZSH version is: $(zsh --version). ${rnl}"
  fi
}

configure_kitty(){
  mkdir -p ${KITTY_PATH}
  for KITTY_CONFIG in ${KITTY_CONFIGS[@]};
    do
      ln -sfn ${SHARED_PATH}/kitty/${KITTY_CONFIG} ${KITTY_PATH}/${KITTY_CONFIG}
    done
  echo -e "${purple}Linked kitty configurations to [${KITTY_PATH}].${rnl}"
}

macos(){
  if [[ $OSTYPE == "darwin"* ]]; then
    echo -e "${red}Detected [${purple}MacOS${red}].${rnl}"
  fi
}

arch(){
  if [[ $OSTYPE == "linux-gnu" ]]; then
    echo -e "${green}Detected [${purple}linux-gnu${green}].${rnl}"
    #install_oh_my_zsh
    configure_kitty
    #configure_dotfiles
  fi
}

#macos
arch
