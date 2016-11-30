# Path to your oh-my-zsh installation.
export ZSH=/home/mpmsimo/.oh-my-zsh

# oh-my-zsh theme
ZSH_THEME="sunaku"

# Uncomment the following line to display red dots whilst waiting for completion.
#COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
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

bindkey -v

# Import alternate zsh configs
#for file in $HOME/dotfiles/zsh/*.zsh; do
#    if [[ $DEBUG > 0 ]]; then
#        echo "zsh: sourcing $file"
#    fi
#    source $file
#done

eval $( dircolors -b $XDG_CONFIG_HOME/zsh/LS_COLORS/LS_COLORS )
export LS_COLORS

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias py=$(which python)
alias aenv=$HOME'/env/bin/activate'

# Enter virtualenv 
. $HOME/osenv/bin/activate
echo ''
python $HOME/Projects/hello_chengyu/hello_chengyu.py

# Enable syntax highlighting
source ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
