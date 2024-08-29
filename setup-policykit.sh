#~/bin/bash

# Create policykit entries

# Get the current Ubuntu version
UBUNTU_VERSION=$(lsb_release -rs)


# Check if the Ubuntu version is 22.04 or 24.04
if [ "$UBUNTU_VERSION" = "22.04" ] || [ "$UBUNTU_VERSION" = "24.04" ]; then
    echo "Ubuntu version: $UBUNTU_VERSION"
else
    echo "Ubuntu version: $UBUNTU_VERSION"
    echo "Ubuntu version is not supported"
    echo "Extend this script to support this version"
    exit 1
fi

RESET_POLKIT_SERVICE=false

# Handle Ubuntu 22.04 authorization policies
if [ "$UBUNTU_VERSION" = "22.04" ]; then
    echo "Ubuntu $UBUNTU_VERSION uses .pkla files to set authoirzation policies"

    # Check if directory /etc/polkit-1/localauthority/50-local.d exists
    # If it does not, exit
    if sudo test ! -d /etc/polkit-1/localauthority/50-local.d; then
        echo "Directory /etc/polkit-1/localauthority/50-local.d does not exist"
        exit 1
    else
        echo "Directory /etc/polkit-1/localauthority/50-local.d was found"
    fi  

    # Read all files in the directory polkit/pkla and if the not exit in /etc/polkit-1/localauthority/50-local.d copy them
    for file in polkit/pkla/*; do
        if sudo test ! -f /etc/polkit-1/localauthority/50-local.d/$(basename $file); then
            echo "Copying $file to /etc/polkit-1/localauthority/50-local.d"
            sudo cp $file /etc/polkit-1/localauthority/50-local.d
            RESET_POLKIT_SERVICE=true
        else
            echo "$(basename $file) already exists in /etc/polkit-1/localauthority/50-local.d"
        fi
    done
fi

# Handle Ubuntu 24.04 authorization policies
if [ "$UBUNTU_VERSION" = "24.04" ]; then
    echo "Ubuntu $UBUNTU_VERSION uses .rules files to set authoirzation policies"

    # Check if directory /etc/polkit-1/rules.d exists
    # If it does not, exit
    if [ ! -d /etc/polkit-1/rules.d ]; then
        echo "Directory /etc/polkit-1/rules.d does not exist"
        exit 1
    else
        echo "Directory /etc/polkit-1/rules.d was found"
    fi

    # Read all files in the directory polkit and if the not exit in /etc/polkit-1/rules.d copy them
    for file in polkit/rules/*; do
        if sudo test ! -f /etc/polkit-1/rules.d/$(basename $file); then
            echo "Copying $file to /etc/polkit-1/rules.d"
            sudo cp $file /etc/polkit-1/rules.d
            RESET_POLKIT_SERVICE=true
        else
            echo "$(basename $file) already exists in /etc/polkit-1/rules.d"
        fi
    done
fi

# Restart polkit
if [ "$RESET_POLKIT_SERVICE" = true ]; then
    echo "Restarting polkit.service"
    sudo systemctl restart polkit.service
else
    echo "No changes to polkit.service"
fi
