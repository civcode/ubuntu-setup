#!/bin/bash

# Check if first argument is the user email
if [ -z "$1" ]; then
    echo "Please provide the user email"
    exit 1
fi

# Check if git user.email is already set
if git config --global user.email | grep -q "$1"; then
    echo "git user.email is already set"
else
    echo "Setting git user.email to $1"
    git config --global user.email "$1"
fi

# Check if git credential.helper is already set
if git config --global credential.helper | grep -q "store"; then
    echo "git credential.helper is already set"
else
    echo "Setting git credential.helper to store"
    git config --global credential.helper store
fi

# Check if git core.editor is already set
if git config --global core.editor | grep -q "vim"; then
    echo "git core.editor is already set"
else
    echo "Setting git core.editor to vim"
    git config --global core.editor "vim"
fi

