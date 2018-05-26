#!/bin/bash
#venv.sh
#Creation of generic virtual environment
#Created: 2/2/17
#Author: mpmsimo
#Usage . ./venv.sh
# Why not pipenv?

ENV="env"
DIR="$HOME/$ENV"

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


initialize_env(){
    echo "Initializing virtual environment $ENV"
    source $DIR/bin/activate
}

check_venv_exists
initialize_env
