# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/Users/lee/go/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/lee/.oh-my-zsh"

ZSH_THEME="robbyrussell"

DISABLE_AUTO_UPDATE="true"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

lg (){
git log --graph --oneline --all
}

aa (){
git add .
git commit -m "$*"
}

pb (){
git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

export TERM=xterm-256color
