# =========================================
# User configuration
# =========================================

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
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

#export AUTOENV=false

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
    git
    kubectl
    macos
    dotenv
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
# Go
# =========================================
export GOROOT=$HOME/.local/go
export GOBIN=$GOROOT/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOBIN
#export GO15VENDOREXPERIMENT=1
export CGO_ENABLED=1

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
alias kchc='kubectl -n honeycomb'
alias ksec='kubectl get --all-namespaces secret -o yaml'
alias kccf='kubectl create -f'
alias poetry='~/venv-poetry/bin/poetry'

# development
alias ns="cd $HOME/noobshack"
alias cv="$GOPATH/src/clairvoyance/bin/clairvoyance"
alias go2="cd ${GOPATH}/src"
alias gor="go run"
#alias vim="vim"
alias python="python3"
alias py="python3"
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

# When we use `Squash and merge` on GitHub,
# `git branch --merged` cannot detect the squash-merged branches.
# As a result, git_remove_merged_local_branch() cannot clean up
# unused local branches. This function detects and removes local branches
# when remote branches are squash-merged.
#
# There is an edge case. If you add suggested commits on GitHub,
# the contents in local and remote are different. As a result,
# This clean up function cannot remove local squash-merged branch.
function git_remove_squash_merged_local_branch() {
  echo "Start removing out-dated local squash-merged branches"
  git checkout -q main &&
    git for-each-ref refs/heads/ "--format=%(refname:short)" |
    while read branch; do
      ancestor=$(git merge-base main $branch) &&
        [[ $(git cherry main $(git commit-tree $(git rev-parse $branch^{tree}) -p $ancestor -m _)) == "-"* ]] &&
        git branch -D $branch
    done
  echo "Finish removing out-dated local squash-merged branches"
}

# =========================================
# Final Block
# =========================================
# Load local secrets...
#. ~/kit/env.sh

# Enable fuzzyfinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/reulan/kit/bin/gcloud/google-cloud-sdk/path.zsh.inc' ]; then . '/home/reulan/kit/bin/gcloud/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/reulan/kit/bin/gcloud/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/reulan/kit/bin/gcloud/google-cloud-sdk/completion.zsh.inc'; fi
