#!/bin/bash
#zsh_plugin_install.sh

# Colorized text options.
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
reset=`tput sgr0`
blue_nl="${blue}\n"

# Paths, dependencies, etc.
KP_PATH=$(dirname $0)

# realpath requires coreutils on mac (`brew install coreutils`)
DEP_ARRAY=('gcloud' 'kubectl' 'realpath')
FILE_PATH_ARRAY=()
BIN_PATH="/usr/local/bin"

which_shell(){
    echo -e "${blue_nl}${FUNCNAME[0]} - Verifying shell is set.${reset}"
    if [[ $SHELL == *"zsh"* ]]; then
        echo "Shell is ZSH: $SHELL"
    fi
}

identify_local_plugins(){
    echo -e "${blue_nl}${FUNCNAME[0]} - Looking for local plugins in.${reset}"
    for PLUGIN in $(ls $KP_PATH);
    do
        if [[ $PLUGIN == *"plugin.zsh"* ]]; then
            PLUGIN_PATH_ARRAY+=($(realpath $PLUGIN))
            echo -e "${green}Located plugin: $PLUGIN.${reset}"
        fi
    done
}

identify_local_plugins(){
    echo -e "${blue_nl}${FUNCNAME[0]} - Looking for local plugins in.${reset}"
    for PLUGIN in $(ls $KP_PATH);
    do
        if [[ $PLUGIN == *"plugin.zsh"* ]]; then
            PLUGIN_PATH_ARRAY+=($(realpath $PLUGIN))
            echo -e "${green}Located plugin: $PLUGIN.${reset}"
        fi
    done
}

identify_public_plugins(){
    echo -e "${blue_nl}${FUNCNAME[0]} - Looking for public plugins in.${reset}"
    for PLUGIN in $(ls $KP_PATH);
    do
        if [[ $PLUGIN == *"plugin.zsh"* ]]; then
            PLUGIN_PATH_ARRAY+=($(realpath $PLUGIN))
            echo -e "${green}Located plugin: $PLUGIN.${reset}"
        fi
    done
}
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

manage_permissions(){
    echo -e "${blue_nl}${FUNCNAME[0]} - Moving the plugins.${reset}"
    for FILE_PATH in ${FILE_PATH_ARRAY[@]}
    do
        FILE=$(basename $FILE_PATH) 
        chmod +x "$FILE"
        echo -e "${green}Updated permissions for $FILE.${reset}"
    done
}

determine_path(){
    echo -e "${blue_nl}${FUNCNAME[0]} - Determine suitable directory within your PATH.${reset}"
    if [[ ":$PATH:" == *":$BIN_PATH:"* ]]; then
        echo -e "${green}$BIN_PATH detected in PATH env var.${reset}"
    else
        echo -e "${red}Unable to locate $BIN_PATH in your PATH env var, please add that before continuing.${reset}"
        exit 1
    fi
}

copy_binaries() {
    echo -e "${blue_nl}${FUNCNAME[0]} - Copying kubectl plugins to$ $BIN_PATH.${reset}"
    for FILE_PATH in ${FILE_PATH_ARRAY[@]}
    do
        FILE=$(basename $FILE_PATH) 
        echo -e "${green}Copying $FILE to $BIN_PATH/$FILE.${reset}"
        cp $FILE $BIN_PATH/$FILE
    done
}

verify_installation() {
    echo -e "${blue_nl}${FUNCNAME[0]} - Verifying that the kubectl plugins have been installed properly.${reset}"
    for FILE_PATH in ${FILE_PATH_ARRAY[@]}
    do
        FILE=$(basename $FILE_PATH) 
        if [ ! -f $FILE_PATH ]; then
            echo -e "${red}$0 - File $FILE not found in $BIN_PATH!.${reset}"
        fi
    done
    echo -e "${green}Plugins have been verified sucessfully.${reset}"
}

{ 
    which_shell
    #check_version
    identify_files
    manage_permissions
    determine_path
    copy_binaries
    #verify_installation
    echo -e "\n${magenta}$0 - zsh plugins have been successfully installed.${reset}"
} || { 
    echo -e "\n${red}$0 - zsh plugin installation failed.${reset}"
}
