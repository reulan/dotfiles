#!/bin/bash
# Bootstrap MacOS or PopOS.

# Set preferred defaults if running on new system
export VISUAL=vim
export EDITOR="$VISUAL"

# Define hardcoded expected paths.
DOTFILE_PATH="${HOME}/dotfiles"
SHARED_PATH="${DOTFILE_PATH}/shared"
SHARED_DOTFILES=('.zshrc' '.gitconfig' '.dotenv' '.vimrc')

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

install_minimal(){
  # Symbolic link shared dotfiles to home directory
  for DOTFILE in ${SHARED_DOTFILES[@]};
  do
    echo -e "${purple}Symlinking ($DOTFILE) to [${HOME}/$DOTFILE].${rnl}"
    ln -sfFn ${SHARED_PATH}/${DOTFILE} ${HOME}
  done
}

main(){
  if [[ $OSTYPE == "darwin"* ]]; then
    echo -e "${red}Detected [${purple}MacOS${red}].${rnl}"
  elif [[ $OSTYPE == "linux-gnu" ]]; then
    echo -e "${green}Detected [${purple}linux-gnu${green}].${rnl}"
    # Deferring CachyOS 4/8/2026
    install_minimal
  elif [[ -L "${SHARED_PATH}/.vimrc" && -d "${SHARED_PATH}/.vimrc" ]]; then
    echo -e "${green}Shared dotfiles exist at [${purple}${DOTFILE_PATH}${green}."
    echo -e "\nRelinking dotfiles.${rnl}"
    install_minimal
  else
    echo -e "${red}Operating system [${OSTYPE}] is not supported.${rnl}"
    echo -e "${red}E${green}x${yellow}i${blue}t${purple}i${setaf6}n${setaf7}g${rnl}"
    exit 1
  fi
}

main
