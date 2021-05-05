# =========================================
# User configuration
# =========================================
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$HOME/.local/bin:$HOME/bin:$HOME/.emacs.d/bin/"

# EMACS DOOM ggnore
export DOOMDIR="$HOME/.config/doom"
export KITTY_CONFIG_DIRECTORY="$HOME/.config/kitty"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='nvim'
    export TERM='rxvt'
fi

# Configure SSH
export SSH_KEY_PATH="~/.ssh/rsa_id"

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

# Additional ZSH options
setopt autocd 
setopt extended_history     ## Store timestamp/runtime in history file
setopt extendedglob 
setopt inc_append_history
setopt ksh_glob 
setopt notify
setopt print_exit_value     ## Print non-zero exit status
setopt prompt_subst 
setopt rm_star_wait         ## Force a pause before allowing an answer on rm *
setopt transient_rprompt    ## Remove the right-side prompt if the cursor comes close

export AUTOENV=false

# =========================================
# ZSH configuration
# =========================================
# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="sunaku"
ZSH_DOTENV_FILE=.dotenv
source $ZSH/oh-my-zsh.sh

# Additional ZSH colorscheme
autoload -U colors && colors
autoload -U compinit && compinit
autoload -U vcs_info && vcs_info

zmodload zsh/complist
zmodload zsh/terminfo

LSCOLORS=exfxcxdxbxegedabagacad
export LSCOLORS
export CLICOLOR=1  

typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE='20'

# =========================================
# ZSH plugins 
# =========================================
plugins=(
            autoenv
            git
            kubectl
            ... dotenv
        )

# =========================================
# Terminal settings
# =========================================
autoload -Uz compinit
compinit

# =========================================
# Keybindings
# =========================================
bindkey -v
bindkey "^R" history-incremental-search-backward

# =========================================
# Homebrew for Linux
# https://docs.brew.sh/Homebrew-on-Linux
# =========================================
test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

# =========================================
# Go 
# =========================================
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
export GO15VENDOREXPERIMENT=1
export CGO_ENABLED=1

# =========================================
# Node
# =========================================
#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# =========================================
# Aliases
# =========================================
# k8's aliases
alias kc=kubectl
alias kce='vim ~/.kube/config'
alias kcd='kubectl describe'
alias kcg='kubectl get'
alias kc3='kubectl config current-context'
alias kcon='kubectl config use-context'
alias kcing='kubectl -n ingress-nginx'
alias ksec='kubectl get --all-namespaces secret -o yaml'
alias kccf='kubectl create -f'

# development
alias ns="cd $HOME/noobshack"
alias xr="cd $HOME/noobshack/xr"
alias sbe="cd $HOME/noobshack/spellblade_engine"
alias cv="$GOPATH/src/clairvoyance/bin/clairvoyance"
alias go2="cd ${GOPATH}/src"
alias gor="go run"
alias vim="nvim"

# utilties
alias diffy='diff -y --suppress-common-lines'
alias tf=terraform
alias tf12="~/kit/terraform0.12/terraform" 

# =========================================
# Functions
# =========================================
function kl() {
     kubectl logs $* | jq -R --raw-output '. as $raw | try (fromjson | .timestamp.seconds |= todateiso8601 | "\(.timestamp.seconds) - \(.filename) - \(.severity) - \(.message)") catch $raw'
}

#function ಠ_ಠ(&$x) { $x .= "¯\_(ツ)_/¯"; ) }
#
# =========================================
# Google Cloud
# =========================================
#export CLOUDSDK_PYTHON="$(which python3.8)"

# =========================================
# Final Block
# =========================================
# Load local secrets...
. ~/kit/env.sh

# Enable fuzzyfinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/reulan/kit/pkg/gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/home/reulan/kit/pkg/gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/reulan/kit/pkg/gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/reulan/kit/pkg/gcloud/google-cloud-sdk/completion.zsh.inc'; fi
