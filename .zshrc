# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="sunaku"

# ZSH plugins
plugins=(git)

# User configuration
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/home/mpmsimo/.local/bin:/home/mpmsimo/bin"

# export MANPATH="/usr/local/man:$MANPATH"
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
fi

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

# Custom keybindings
bindkey -v
bindkey "^R" history-incremental-search-backward

# Import alternate zsh configs
#for file in $HOME/dotfiles/zsh/*.zsh; do
#    if [[ $DEBUG > 0 ]]; then
#        echo "zsh: sourcing $file"
#    fi
#    source $file
#done

#eval $( dircolors -b $XDG_CONFIG_HOME/zsh/LS_COLORS/LS_COLORS )
#export LS_COLORS

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# aliases
alias py=$(which python)
alias tf=terraform

# k8's aliases
alias kc=kubectl
alias kcsc='kubectl config use-context'

# Enter virtualenv 
AENV=$HOME'/env/bin/activate'
source $AENV

# Golang export variables
export GOPATH=$(pwd)
export PATH=$PATH:$GOPATH/bin
export GO15VENDOREXPERIMENT=1
export CGO_ENABLED=1
#export GOPATH=$HOME/golang
#export GOROOT=/usr/local/opt/go/libexec
#export GOBIN=$GOPATH/bin
#export PATH=$PATH:$GOPATH
#export PATH=$PATH:$GOROOT/bin

# Enable syntax highlighting
# source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Local scripts

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME'/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/msimo/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME'/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/msimo/google-cloud-sdk/completion.zsh.inc'; fi
