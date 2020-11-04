#!/bin/bash
# Bootstrap MacOS or PopOS.

# Set preferred defaults if running on new system
export VISUAL=nvim
export EDITOR="$VISUAL"

# Define hardcoded expected paths.
DOTFILE_PATH="${HOME}/dotfiles"
SHARED_PATH="${DOTFILE_PATH}/shared"
MACOS_PATH="${DOTFILE_PATH}/macos"
POPOS_PATH="${DOTFILE_PATH}/popos"
ARCH_PATH="${DOTFILE_PATH}/arch"

CONFIG_PATH="${HOME}/.config"
KITTY_PATH="${CONFIG_PATH}/kitty"
NVIM_PATH="${CONFIG_PATH}/nvim"

# Define files that will need to be transferred.
# nvim note: .vimrc is required for init.vim untill it's fully converted over
SHARED_DOTFILES=('.zshrc' '.gitconfig' '.dotenv' '.vimrc')
KITTY_CONFIGS=('kitty.conf' 'colorscheme.conf' 'keybindings.conf' 'macos.conf' 'jellybeans.conf')
MACOS_DOTFILES=('.skhdrc' '.yabairc' 'Brewfile')
POPOS_DOTFILES=('Brewfile')

DOTFILE_TO_CHECK="${NVIM_PATH}/init.vim"

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

# =========================================
# Operating System (PopOS or MacOS)
# =========================================
install_macos(){
  echo -e "${blue}Configuring MacOS specific settings.${rnl}\n"

  # Configure yabai and skhd
  for DOTFILE in ${MACOS_DOTFILES[@]};
  do
    echo -e "${purple}Symlinking (${DOTFILE}) to [${HOME}/$DOTFILE].${rnl}"
    ln -sfFn ${MACOS_PATH}/${DOTFILE} ${HOME}
  done

  # TODO: Configure kitty specific MacOS settings
  # 'macos.conf'  - write an include in the main config

  echo -e "${red}Install Homebrew manually, then rerun this script.${rnl}"
  echo -e "${red}/bin/bash -c $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)${rnl}"
  #install_homebrew

  # Enable window + hotkey manager
  echo -e "${blue}Enabling MacoOS brew services.${blue}"
  brew services start skhd
  brew services start yabai
}

install_popos(){
  echo -e "${blue}Installing PopOS settings.${rnl}\n"
  sudo apt install libavcodec-extra build-essential zsh -y

  echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> ${HOME}/.zprofile
  eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

  for DOTFILE in ${POPOS_DOTFILES[@]};
  do
    echo -e "${purple}Symlinking (${DOTFILE}) to [${HOME}/$DOTFILE].${rnl}"
    ln -sfFn ${POPOS_PATH}/${DOTFILE} ${HOME}
  done

  install_linux_utilities
  install_homebrew
  install_python
}

install_arch(){
  echo -e "${blue}Installing Arch Linux operating system settings.${rnl}\n"
  sudo pacman -Syuq --noconfirm vim neovim git kitty discord chromium terraform terragrunt

  install_oh_my_zsh
  configure_kitty
  configure_nvim
  link_shared
}

# =========================================
# Package manager (Homebrew + online mirrors)
# =========================================
install_homebrew(){
  cd /tmp

  # Install Homebrew,
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  
  # Locate the Brewfile and execute it.
  brew tap Homebrew/bundle
  brew bundle --file="${HOME}/Brewfile"
}

install_linux_utilities(){
  sudo apt-get install kitty -y

  # Add the Cloud SDK distribution URI as a package source & Import the Google Cloud Platform public key
  echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
  # Update the package list and install the Cloud SDK
  sudo apt-get update && sudo apt-get install google-cloud-sdk -y

  sudo apt-get install docker docker.io -y
  sudo usermod -aG docker ${USER}
}

# =========================================
# Shell (zsh) + Terminal (kitty)
# =========================================
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

# =========================================
# Terminal (kitty)
# =========================================
configure_kitty(){
  mkdir -p ${KITTY_PATH}
  for KITTY_CONFIG in ${KITTY_CONFIGS[@]};
    do
      ln -sfn ${SHARED_PATH}/kitty/${KITTY_CONFIG} ${KITTY_PATH}/${KITTY_CONFIG}
    done
  echo -e "${purple}Linked kitty configurations to [${KITTY_PATH}].${rnl}"
}

# =========================================
# Text editor (nvim, vim-plug)
# =========================================
configure_nvim(){
  mkdir -p ${NVIM_PATH}
  echo "Copying ${SHARED_PATH}/.vim > [${HOME}/.vim]."
  cp -r "${SHARED_PATH}/.vim" ${HOME} || true

  # vim-plug
  echo -e "${yellow}Installing vim-plug.${rnl}"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # symlink config
  echo -e "${purple}Symlinking (${SHARED_PATH}/init.vim) to [${NVIM_PATH}/init.vim].${rnl}"
  ln -sfn ${SHARED_PATH}/init.vim ${NVIM_PATH}/init.vim
}

install_python(){
    cd /tmp
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py

    # wallpaper terminal colorizer
    pip3 install pywal
}

# =========================================
# Shared installation
# =========================================
# Configure vim, kitty, chunkwm and move remote configs + directories
link_shared(){
  # Symbolic link shared dotfiles to home directory
  for DOTFILE in ${SHARED_DOTFILES[@]};
  do
    echo -e "${purple}Symlinking ($DOTFILE) to [${HOME}/$DOTFILE].${rnl}"
    ln -sfFn ${SHARED_PATH}/${DOTFILE} ${HOME}
  done
}

install_shared(){
  echo -e "${purple}Bootstrapping Operating System.${rnl}"
  echo -e "${red}Please type SSH password, so that GitHub can be accessed: .${rnl}"
  ssh-add
  install_oh_my_zsh
  configure_kitty
  configure_nvim
  link_shared
}

# =========================================
# Main logic
# 
# - support relinking via option

# - update to support nvim
# ~/.config/nvim/init.vim 
# =========================================

bootstrap(){
  if [[ $OSTYPE == "darwin"* ]]; then
    echo -e "${green}Detected [${purple}MacOS${green}].${rnl}"
    install_macos
    install_shared
  elif [[ $OSTYPE == "linux-gnu" ]]; then
    echo -e "${green}Detected [${purple}linux-gnu${green}].${rnl}"
    # Deferring to Manjaro as preferred OS instead of PopOS! as of 11/2020
    #install_popos
    install_arch
    install_shared
  elif [[ -L "${SHARED_PATH}/.vimrc" && -d "${SHARED_PATH}/.vimrc" ]]; then
    echo -e "${green}Shared dotfiles exist at [${purple}${DOTFILE_PATH}${green}."
    echo -e "\nRelinking dotfiles.${rnl}"
    link_shared
  else
    echo -e "${red}Operating system [${OSTYPE}] is not supported.${rnl}"
    echo -e "${red}E${green}x${yellow}i${blue}t${purple}i${setaf6}n${setaf7}g${rnl}"
    exit 1
  fi
}

bootstrap
