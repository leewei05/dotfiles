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

# dep
# shell


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

setup_editor() {
    title "Setup Editor"

    info "Check alacritty"
    case "$OS" in
        Linux)
            # TODO
            ;;
        Darwin)
            if open -Ra "alacritty" ; then
                info "Alacritty already exists... Skipping."
            else
                info "Install alacritty"
                if [ ! -d ~/tmp/alacritty ]; then
                    git clone https://github.com/alacritty/alacritty.git ~/tmp/alacritty
                    cd ~/tmp/alacritty
                    rustup override set stable
                    rustup update stable
                    make app
                    cp -r target/release/osx/Alacritty.app /Applications/
                    info "Clean up alacritty repository"
                    rm -rf ~/tmp/alacritty
                fi
            fi
            ;;
    esac

    info "Create alacritty dir"
    mkdir -p $HOME/.config/alacritty
    config_file="$(fd -a alacritty.yml .config -t file)"
    target="$HOME/.config/alacritty/$(basename "$config_file")"

    if [ -e "$target" ]; then
        info "~${target#$HOME} already exists... Skipping."
    else
        info "Creating symlink for $config_file"
        ln -s "$config_file" "$target"
    fi
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
		info "fzf already exists... Skipping."
	else
	    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	    ~/.fzf/install --completion --update-rc --key-bindings
	fi
}

setup_fish() {
    title "Installing fish"

    info "Install fish shell"
	if ! type "fish" > /dev/null; then
        case "$OS" in
        Linux)
            sudo apt-add-repository ppa:fish-shell/release-3
            sudo apt-get update && sudo apt-get upgrade
            sudo apt-get install fish
            ;;
        Darwin)
            brew install fish
            ;;
    esac
    fi

    info "Set up fish as default shell"
    echo /usr/local/bin/fish | sudo tee -a /etc/shells
    chsh -s /usr/local/bin/fish

    # This can only run in fish shell
    info "Install fisher, fish plugin manager"
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

    info "Create fish dir"
    mkdir -p $HOME/.config/fish
    source_files="$(fd -a . .config/fish -t file)"

    for file in $source_files; do
	info "$file"
	target="$HOME/.config/fish/$(basename "$file")"
	if [ -e "$target" ]; then
	    info "~${target#$HOME} already exists... Skipping."
	else
	    info "Creating symlink for $file"
	    ln -s "$file" "$target"
	fi
    done

}

setup_nvim() {
    title "Install neovim"

    if ! command -v nvim &> /dev/null; then
        info "Install neovim on $OS"
        case "$OS" in
        Linux)
            sudo apt-get install neovim
            ;;
        Darwin)
            brew install neovim
            ;;
        esac
    else
        info "Neovim already exists... Skipping."
    fi

    if [ ! -f ~/.config/nvim/init.vim ]; then
        info "Creating $NVIM"
        mkdir -p $NVIM
        git clone --depth=1 git@github.com:leewei05/nvim-config.git $NVIM
    else
        info "Config already exists... Skipping."
    fi

    info "Install vim-plug"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    nvim -c 'PlugInstall' -c 'qa'
}

setup_dep () {
    title "Install miscellaneous tools"
    case "$OS" in
        Linux)
            sudo apt update
            sudo apt-get install fd-find
                wget \
                curl \
                python3 \
		tig \
		bat \
                -y
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
            ;;
        Darwin)
            brew install fd \
                wget \
                curl \
                python3 \
		tig \
		bat

	    if ! type "rustup" > /dev/null; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	    fi
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
    editor)
        setup_editor
        ;;
    dep)
        setup_dep
        ;;
    all)
	setup_symlinks
        setup_fzf
        setup_fish
        setup_nvim
		;;
    *)
        echo -e $"\nUsage: $(basename "$0") {link|nvim|shell|dep|all}\n"
        exit 1
        ;;
esac
