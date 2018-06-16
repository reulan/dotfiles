# =========================================
# User configuration
# =========================================
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$HOME/.local/bin:$HOME/bin"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Kitty
export KITTY_CONFIG_DIRECTORY=$HOME/Library/Preferences/kitty/kitty.conf

# =========================================
# ZSH configuration
# =========================================

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="kennethreitz"
#ZSH_THEME="sunaku"
# export MANPATH="/usr/local/man:$MANPATH"
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
plugins=(git)

# Enable syntax highlighting
#source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# =========================================
# Keybindings
# =========================================
bindkey -v
bindkey "^R" history-incremental-search-backward

# =========================================
# Aliases
# =========================================
alias py=$(which python)
alias tf=terraform

# k8's aliases
alias kc=kubectl
alias kcd='kubectl describe'
alias kcon='kubectl config use-context'
alias kc3='kubectl config current-context'

# utilties
alias diffy='diff -y --suppress-common-lines'

# =========================================
# Python 
# =========================================
# Enter virtualenv 
AENV=$HOME'/env/bin/activate'
source $AENV

# =========================================
# Go 
# =========================================
export GOPATH=$(pwd)
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
# Functions
# =========================================
# Ansible Vault
decrypt ()
{
    #ansible-vault decrypt --vault-password-file=~/.vault_kd $1
    ansible-vault decrypt --vault-password-file=~/.vault_ai $1
}

encrypt ()
{
    echo -n "$1" | ansible-vault encrypt_string --vault-password-file=~/.vault_kd --stdin-name secretName
}

# Other
mkcdir ()
{
    mkdir -p -- "$1" &&
    cd -P -- "$1"
}

mknow ()
{
    DATE=`date +%Y%m%d`
    mkdir -p -- "$DATE" &&
    cd -P -- "$DATE"
}

# Kubernetes
cordon ()
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

uncordon () {
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

# Enable fuzzyfinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
