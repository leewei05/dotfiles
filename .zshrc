
# Path to your oh-my-zsh installation.
export ZSH="/Users/leewei/.oh-my-zsh"
export GOPATH="/Users/leewei/go"

export PATH=$HOME/bin:/usr/local/bin:$PATH:$GOPATH/bin
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
#source "/usr/local/Cellar/kube-ps1/0.7.0/share/kube-ps1.sh"
#PS1='$(kube_ps1)'$PS1
# alias pip=pip3

export TERM=xterm-256color

macdown() {
    "$(mdfind kMDItemCFBundleIdentifier=com.uranusjr.macdown | head -n1)/Contents/SharedSupport/bin/macdown" $@
}

function sdev (){
gcloud beta compute ssh --zone "asia-east1-a" "ondemand-service-g1w7" --project "media17-dev"
}

function vh (){
open https://vim.rtorr.com/
}

function vgo (){
open https://github.com/fatih/vim-go-tutorial
}

lg (){
git log --graph --oneline --all
}

source $GOPATH/src/github.com/17media/api/env.sh

# bind cursor key

bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins=(zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
 fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="/usr/local/opt/go@1.13/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/leewei/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/leewei/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/leewei/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/leewei/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

function get_cluster_short() {
  echo "$1" | cut -d _ -f4 
}

function get_namespace_upper() {
  echo "$1" # | tr '[:lower:]' '[:upper:]'
}

export KUBE_PS1_NAMESPACE_FUNCTION=get_namespace_upper
KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short

# kubectl promp
source "/usr/local/Cellar/kube-ps1/0.7.0/share/kube-ps1.sh"
PS1=$PS1'> $(kube_ps1)'
NEWLINE=$'\n''$ '
PS1=$PS1${NEWLINE}

KUBE_PS1_SEPARATOR=''
KUBE_PS1_SYMBOL_DEFAULT=''
KUBE_PS1_SYMBOL_COLOR='cyan'
KUBE_PS1_CTX_COLOR='green'
