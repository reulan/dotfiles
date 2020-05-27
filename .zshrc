# =========================================
# User configuration
# =========================================
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$HOME/.local/bin:$HOME/bin"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
    export TERM='rxvt'
fi

# Configure SSH
export SSH_KEY_PATH="~/.ssh/rsa_id"
#ssh-add

HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_REDUCE_BLANKS

# =========================================
# ZSH configuration
# =========================================

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="sunaku"
source $ZSH/oh-my-zsh.sh

# Additional ZSH colorscheme
autoload -U colors && colors
autoload -U compinit && compinit
autoload -U vcs_info && vcs_info

zmodload zsh/complist
zmodload zsh/terminfo

# setopt
setopt \
  autocd \
  ksh_glob \
  extendedglob \
  prompt_subst \
  inc_append_history

# =========================================
# ZSH plugins 
# =========================================
plugins=(
            autoenv
            git
            jira
            kubectl
            systemadmin
        )

# =========================================
# Terminal settings
# =========================================
autoload -Uz compinit
compinit

# Enable syntax highlighting
#source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# =========================================
# Keybindings
# =========================================
bindkey -v
bindkey "^R" history-incremental-search-backward

# =========================================
# Aliases and Functions
# =========================================

# k8's aliases
alias kc=kubectl
alias kcd='kubectl describe'
alias kcon='kubectl config use-context'
alias kc3='kubectl config current-context'
alias kcg='kubectl get'

# utilties
alias diffy='diff -y --suppress-common-lines'
alias tf=terraform

# development
alias cv="$GOPATH/src/clairvoyance/bin/clairvoyance"
alias go2='cd $GOPATH/src'

# =========================================
# Functions
# =========================================

### Google Cloud Platform
function gcloud-ssh()
{
    PROJECT=$1
    INSTANCE=$2
    gcloud beta compute --project $PROJECT ssh --zone us-east1-b $INSTANCE --tunnel-through-iap
}

### Ansible Vault
function decrypt()
{
    ansible-vault decrypt --vault-password-file=~/.vault_kd $1
    #ansible-vault decrypt --vault-password-file=~/.vault_ai $1
}

function encrypt()
{
    echo -n "$2" | ansible-vault encrypt_string --vault-password-file=~/.vault_kd --stdin-name $1
    #ansible-vault encrypt_string --name $1 --vault-password-file='~/.vault_kd' $2
}

function encryptf()
{
    ansible-vault encrypt --vault-password-file=~/.vault_kd $1
}

### Kubernetes
function cordon()
{
    CONTEXT=$(kubectl config current-context)

    if [[ $# -ne 3 ]]; then
        echo "usage: cordon NODE REASON YYYYMMDD"
    else
        NODE=$1
        REASON="$2"
        EXPIREDATE=$3

        if [[ $REASON =~ "[0-9a-zA-Z_-]" ]]; then 
            true
        else
            echo "$REASON is not a single alphanumeric string less than 63 characters."
            return
        fi

        if [[ $EXPIREDATE =~ ^[0-9]{8}$ ]] && date -f "%Y%m%d" -j "$EXPIREDATE" >/dev/null 2>&1; then
            true
        else
            echo "$EXPIREDATE is not a valid date format, use digits [0-9] in YYYYMMDD format."
            return
        fi

        echo "Cordoning Kubernetes node $NODE until $EXPIREDATE in the [$CONTEXT] context for: $REASON."
        kubectl cordon $NODE
        kubectl label node $NODE cordonReason="$REASON" --overwrite
        kubectl label node $NODE cordonExpire="$EXPIREDATE" --overwrite
    fi
}

function uncordon() {
    CONTEXT=$(kubectl config current-context)
    NODE=$1

    if [[ $# -ne 1 ]]; then
        echo "usage: uncordon NODE"
    else
        echo "Uncordon Kubernetes node $NODE in [$CONTEXT] context."
        kubectl uncordon $NODE
        kubectl label node $NODE cordonReason-
        kubectl label node $NODE cordonExpire-
    fi
}

### Kubernetes
function kl() {
     kubectl logs $* | jq -R --raw-output '. as $raw | try (fromjson | .timestamp.seconds |= todateiso8601 | "\(.timestamp.seconds) - \(.filename) - \(.severity) - \(.message)") catch $raw'
 }

function eskl() {
     kubectl logs $* | jq -R --raw-output '. as $raw | try (fromjson | .timestamp.seconds |= todateiso8601 | "\(.timestamp.seconds) - \(.type) - \(.statusCode) - \(.message)") catch $raw'
     kubectl logs $* | jq -R --raw-output '. as $raw | try (fromjson | "\(.res) -  \(.message)") catch $raw'
 }

### Git
function mergebranch() {
    { GIT_REPO_NAME=$(basename -s .git $(git config --get remote.origin.url)) } || { echo "Please navigate to a valid git directory." && return 0 }
    #read -e -p "Merge '$1' into '$2' for git repo '$GIT_REPO_NAME'? " REPLY
    tput setaf 2
    read "REPLY?Merge '$1' into '$2' for git repo '$GIT_REPO_NAME'? (y/n) "
    tput sgr0
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        git checkout $1
        git pull origin $1
        git submodule update --init
        git rev-parse HEAD

        git checkout $2
        git pull origin $2
        git rev-parse HEAD

        tput setaf 3
        echo "\nTo push up this branch run:"
        tput setaf 4
        echo "git merge $1\ngit push"
        tput sgr0
    else
        echo -e "Unable to merge $1 into $2."
    fi
}

### System
function mkcdir ()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

function mknow ()
{
    DATE=`date +%Y%m%d`
    mkdir -p -- "$DATE" &&
    cd -P -- "$DATE"
}

# =========================================
# Go 
# =========================================
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GO15VENDOREXPERIMENT=1
export CGO_ENABLED=1

# =========================================
# Google Cloud
# =========================================
# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME'/google-cloud-sdk/path.zsh.inc' ]; then source $HOME'/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME'/google-cloud-sdk/completion.zsh.inc' ]; then source $HOME'/google-cloud-sdk/completion.zsh.inc'; fi

# =========================================
# Node
# =========================================
#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# =========================================
# Final Block
# =========================================
# Enable fuzzyfinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
