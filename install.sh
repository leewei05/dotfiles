#!/bin/bash

DOTFILES="$(pwd)"
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

info() {
    echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

title() {
    echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
    echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

get_linkables() {
		find "$PWD" -maxdepth 1 -type f -not -name "*.sh"
}

setup_symlinks() {
    title "Creating symlinks"

		for file in $(get_linkables) ; do
				echo "$file"
        target="$HOME/$(basename "$file")"
        if [ -e "$target" ]; then
            info "~${target#$HOME} already exists... Skipping."
        else
            info "Creating symlink for $file"
            ln -s "$file" "$target"
        fi
    done
}

setup_fzf() {
    title "Installing fzf"

		if [ -d "$HOME/.fzf" ]; then
				info "fzf exists, skipping installation"
		else
		    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		    ~/.fzf/install --completion --update-rc --key-bindings
		fi
}

case "$1" in
    link)
        setup_symlinks
        ;;
		all)
				setup_symlinks
				setup_fzf
				;;
esac
