#!/usr/bin/env bash

# TODO: check if running in TMUX (tests work better that way) env variable $TMUX
# TODO: check if nerdfonds are installed

# test if p4c/bin in path

# nvim 7.2
# tmux 2.2
# zsh ??

echo "About to run 'nvim :checkhealth'. Press <enter> to continue.. "; read
nvim +:checkhealth

echo "Testing truecolor support."
test_truecolor.sh

echo "About to check true color in nvim. Press <enter> to continue.. "; read
nvim "+:term test_truecolor.sh"

