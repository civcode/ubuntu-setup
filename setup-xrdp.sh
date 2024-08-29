#!/bin/bash

# Install xrdp
# Check if xrdp is already installed
# If it is not, install it
# If it is, do nothing
if ! dpkg -l | grep -q xrdp; then
    echo "Installing xrdp"
    sudo apt-get update && sudo apt-get install -y xrdp
else
    echo "xrdp is already installed"
fi

# Check is user is in group ssl-cert
# If not, add user to group ssl-cert
LOGOUT_NEEDED=false
if ! groups | grep -q ssl-cert; then
    echo "Adding user to group ssl-cert"
    sudo usermod -a -G ssl-cert $USER
    LOGOUT_NEEDED=true
else
    echo "User is already in group ssl-cert"
fi

# Check if user is in group render
# If not, add user to group render
if ! groups | grep -q render; then
    echo "Adding user to group render"
    sudo usermod -a -G render $USER
    LOGOUT_NEEDED=true
else
    echo "User is already in group render"
fi

# Check if ~/.xsession exists
# If it does not, create it and append myxsession to it
if [ ! -f ~/.xsession ]; then
    echo "Creating ~/.xsession"
    cat myxsession > ~/.xsession
else
    echo "~/.xsession already exists"
fi

# Check if ~/.xsessionrc exists
# If it does not, create it and append myxsessionrc to it
if [ ! -f ~/.xsessionrc ]; then
    echo "Creating ~/.xsessionrc"
    cat myxsessionrc > ~/.xsessionrc
else
    echo "~/.xsessionrc already exists"
fi

# Policykit setup
./setup-policykit.sh

# Tell the user to log out to activat new group memberships
if [ "$LOGOUT_NEEDED" = true ]; then
    echo "Please log out to activate new group memberships"
    echo "sudo loginctl kill-user $USER"
    echo "After logging out, you can connect to the machine via RDP"
else
    echo "You can connect to the machine via RDP"
fi

