
# Path to your oh-my-zsh installation.
export ZSH="/Users/leewei/.oh-my-zsh"
export GOPATH="/Users/leewei/go"
export CLOUDSDK_PYTHON=python2

export PATH=$HOME/bin:/usr/local/bin:$PATH:$GOPATH/bin
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
#source "/usr/local/Cellar/kube-ps1/0.7.0/share/kube-ps1.sh"
#PS1='$(kube_ps1)'$PS1
# alias pip=pip3

export TERM=xterm-256color
export KUBE_EDITOR="vim"

macdown() {
    "$(mdfind kMDItemCFBundleIdentifier=com.uranusjr.macdown | head -n1)/Contents/SharedSupport/bin/macdown" $@
}

function f(){
  vim $(fzf)
}

function t(){
totp p | pbcopy
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

export PATH="/usr/local/opt/helm@2/bin:$PATH"
