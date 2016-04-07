#!/bin/bash
#gamedev.sh
#Creation of gamedev environment
#Created: 4/6/16
#Author: mpmsimo
#Usage . ./gamedev.sh

ENV="env"
DIR="$HOME/$ENV"
GAMEDIR=$HOME/gamedev/spellblade_legacy

check_venv_exists(){
    if [ ! -d $DIR ]
        then
            create_virtualenv
    else
        echo "virtualenv $DIR already exists."
    fi
}

create_virtualenv(){
    cd $HOME
    virtualenv -p $(which python3) env
}

check_sbl_exists(){
    if [ ! -d $GAMEDIR ]
        then
            setup_sbl_repo
    else
        echo "Directory $GAMEDIR already exists."
    fi
}

setup_sbl_repo(){
    mkdir -p $HOME/gamedev
    cd $HOME/gamedev
    git clone git@github.com:mpmsimo/spellblade_legacy.git
}

initialize_env(){
    echo "Initializing virtual environment $ENV"
    source $DIR/bin/activate
    echo "Changing directory to $GAMEDIR"
    cd $GAMEDIR
    git pull
}

check_venv_exists
check_sbl_exists
initialize_env
