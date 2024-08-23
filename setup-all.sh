#!/bin/bash

# Setting up the environment by calling all setup scripts
echo "Setting up the environment"
echo ""

# Make all setup scripts executable
chmod +x setup-*

# Git setup
# Get email used for git, print the input and aks user to confirm it
SKIP_GIT_SETUP=false
echo "Git setup"
read -p "Enter the email you use for git (press enter to skip): " email
if [ -z "$email" ]; then
    SKIP_GIT_SETUP=true
    echo "Skipping git setup"
    echo
fi
if [ "$SKIP_GIT_SETUP" = false ]; then
echo "You entered: $email"
    read -p "Is this correct? (y/n) " confirm
    if [ "$confirm" != "y" ]; then
        echo "Please run the script again and enter the correct email"
        exit 1
    fi
    # Running the setup-git.sh script
    ./setup-git.sh $email
    echo ""
fi

# Environment setup
# Running the setup-environment.sh script
echo "Environment setup"
./setup-environment.sh
echo ""

# xRDP setup
echo "xRDP setup is NOT done automatically"
echo "Please run the setup-xrdp.sh script manually"
echo ""

# Realtime environment setup
# Running the setup-realtime.sh script
echo "Realtime environment is NOT set up automatically"
echo "Please run the setup-realtime.sh script manually"
echo ""

