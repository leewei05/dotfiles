#!/bin/bash

DOTFILES="$(pwd)"
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"
OS="`uname`"
NVIM=$HOME/.config/nvim

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

get_nvim_configs() {
    find "$PWD/.config/nvim" -maxdepth 1 -type f 
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

setup_git() {
    title "Installing and setting up git"

    info "Install git"
    case "$OS" in
        Linux)
            sudo apt install git-all
            ;;
        Darwin)
            xcode-select --install
            ;;
    esac
    info "Setup git"
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

setup_fish() {
    title "Installing fish"

    info "Install fish shell"
	if ! type "fish" > /dev/null; then
		wget https://github.com/fish-shell/fish-shell/releases/download/3.5.0/fish-3.5.0.tar.xz 
    fi
	
	#git clone https://github.com/fish-shell/fish-shell.git ~/.local/share/fish-shell
	#cd ~/.local/share/fish-shell; cmake .; make; sudo make install

    info "Set up fish as default shell"
    echo /usr/local/bin/fish | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/fish
}

setup_nvim() {
    title "Install neovim"

    info "Install vim-plug"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    info "Install neovim on $OS"
    case "$OS" in
        Linux)
            sudo apt-get install neovim
            ;;
        Darwin)
            brew install neovim
            ;;
    esac

    info "Creating $NVIM"
    mkdir -p $NVIM

    info "Creating symlinks"
    for file in $(get_nvim_configs) ; do
		echo "$file"
        target="$NVIM/$(basename "$file")"
        if [ -e "$target" ]; then
            info "~${target#$NVIM} already exists... Skipping."
        else
            info "Creating symlink for $file"
            ln -s "$file" "$target"
        fi
    done
}

setup_misc () {
    title "Install miscellaneous tools"
    case "$OS" in
        Linux)
            sudo apt-get install fd-find
            ;;
        Darwin)
            brew install fd
            ;;
    esac
}

case "$1" in
    link)
        setup_symlinks
        ;;
    nvim)
        setup_nvim
        ;;
    shell)
        setup_fish
        ;;
    misc)
        setup_misc
        ;;
	all)
		setup_symlinks			
        setup_fzf	
        setup_fish
        setup_nvim
		;;
    *)
        echo -e $"\nUsage: $(basename "$0") {link|nvim|shell|misc|all}\n"
        exit 1
        ;;
esac
