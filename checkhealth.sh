#!/usr/bin/env bash

if [ -z "$TMUX" ] ; then
    echo 'Please run in tmux.'
    exit 1
fi

# TODO: check if nerdfonds are installed

# test if p4c/bin in path

# nvim 7.2
# nvim --version
# tmux 2.2
# tmux -V
# zsh ??

echo "About to run 'nvim :checkhealth'. Press <enter> to continue.. "; read -r
nvim +:checkhealth

echo "Testing truecolor support."
test_truecolor.sh

echo "About to check true color in nvim. Press <enter> to continue.. "; read -r
nvim "+:term test_truecolor.sh"

