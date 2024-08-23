#!/bin/bash

# Read mybashrc and append to ~/.bashrc
# Get the first three lines of mybashrc and check if they are already in ~/.bashrc
# If they are not, append mybashrc to ~/.bashrc
# If they are, do nothing
mybashrc_header=$(head -n 3 mybashrc)
if ! grep -Fxq "$mybashrc_header" ~/.bashrc; then
    # Append 5 empty lines to ~/.bashrc
    printf "\n\n\n\n\n" >> ~/.bashrc
    echo "Appending mybashrc to ~/.bashrc"
    cat mybashrc >> ~/.bashrc
else
    echo "mybashrc is already in ~/.bashrc"
fi

# Check if ~/.vimrc exists
# If it does not, create it and append myvimrc to it
if [ ! -f ~/.vimrc ]; then
    echo "Creating ~/.vimrc"
    cat myvimrc > ~/.vimrc
else
    echo "~/.vimrc already exists"
fi

# Check if ~/.tmux.conf exists
# If it does not, create it and append mytmux.conf to it
if [ ! -f ~/.tmux.conf ]; then
    echo "Creating ~/.tmux.conf"
    cat mytmux.conf > ~/.tmux.conf
else
    echo "~/.tmux.conf already exists"
fi

