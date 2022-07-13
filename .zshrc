#########################
# Environment variables #
#########################
export PATH=$HOME/bin:/usr/local/bin:/Users/lee/go/bin:$PATH
export ZSH="/Users/lee/.oh-my-zsh"
export TERM=xterm-256color

alias vim=nvim

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
