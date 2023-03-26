#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "About to install p4c environment setup!"

if [[ "$DIR" != "${HOME}/p4c" ]]; then
	>&2 echo "have to be cloned to ${HOME}/p4c"
	exit 1
fi

function install_file() {
	local what=$1
	local where=$2

	if [[ -e "$where" ]]; then
		echo "File $where exists. Remove?"
		rm -rfi $where
		if [[ -e "$where" ]]; then
			echo "$what not installed"
			return
		fi
	fi
	echo "Installing $what to $where"
	ln -si $what $where
}

install_file ${HOME}/p4c/etc/tmux.conf ${HOME}/.tmux.conf
install_file ${HOME}/p4c/etc/bashrc ${HOME}/.bashrc
install_file ${HOME}/p4c/etc/zshrc ${HOME}/.zshrc
install_file ${HOME}/p4c/config/tmux ${HOME}/.tmux
install_file ${HOME}/p4c/config/vim ${HOME}/.config/nvim
install_file ${HOME}/p4c/config/alacritty ${HOME}/.config/alacritty
install_file ${HOME}/p4c/config/tridactylrc ${HOME}/.tridactylrc
install_file ${HOME}/.config/nvim ${HOME}/.vim

echo "now inside of vim/nvim call :InstallPlugins"
echo "you will also need to install NerdFont - check vimrc"
echo 'mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf'

echo "For anything requiring your attention in neovim try: :CheckHealth"
