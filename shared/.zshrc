# =========================================
# User configuration
# =========================================
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$HOME/.local/bin:$HOME/bin:$HOME/.emacs.d/bin/"
# add python
export PATH="$PATH:/Users/mps/Library/Python/3.9/bin"
# add brew
export PATH="$PATH:/opt/homebrew/bin"
# add poetry
export PATH="$PATH:$HOME/venv-poetry/poetry/bin"
# add pyenv
export PATH="$PATH:/opt/homebrew/bin/pyenv"
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc

# rust
source "$HOME/.cargo/env"

# EMACS DOOM ggnore
export DOOMDIR="$HOME/.config/doom"
export KITTY_CONFIG_DIRECTORY="$HOME/.config/kitty"

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
# Homebrew for MacOS
# =========================================
#eval "$(homebrew/bin/brew shellenv)"
#brew update --force --quiet
#chmod -R go-w "$(brew --prefix)/share/zsh"

# =========================================
# Go
# =========================================
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN
#export GO15VENDOREXPERIMENT=1
export CGO_ENABLED=1
#eval "$(goenv init -)"
#. /usr/local/opt/asdf/libexec/asdf.sh
#if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
#eval "$(direnv hook zsh)"
#. $HOME/.asdf/asdf.sh

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
alias pictor="cd ~/pictorus/pictorus"

# =========================================
# Functions
# =========================================
function kl() {
     kubectl logs $* | jq -R --raw-output '. as $raw | try (fromjson | .timestamp.seconds |= todateiso8601 | "\(.timestamp.seconds) - \(.filename) - \(.severity) - \(.message)") catch $raw'
}

function dev_server () {
  pushd /Users/dillonmcewan/Projects/Pictorus/pictorus
  PICTORUS_ENV=$1 FLASK_ENV=development ./script/server
  popd
}

function dev_queue() {
  pushd /Users/dillonmcewan/Projects/Pictorus/pictorus
  PICTORUS_ENV=$1 USE_EMQ=true ./script/build_queue
  popd
}

function dev_frontend() {
  pushd /Users/dillonmcewan/Projects/Pictorus/pictorus
  ./script/frontend
  popd
}

function start_dev() {
  PICTORUS_ENV="${PICTORUS_ENV:=local}"
  tab dev_queue $PICTORUS_ENV
  tab dev_server $PICTORUS_ENV
  tab dev_frontend
  open -a "Google Chrome" http://localhost:5173
}

#function ಠ_ಠ(&$x) { $x .= "¯\_(ツ)_/¯"; ) }

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

# Python env setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
