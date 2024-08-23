#~/bin/bash

# Create policykti entries
# Check if directory /etc/polkit-1/rules.d exists
# If it does not, exit
if [ ! -d /etc/polkit-1/rules.d ]; then
    echo "Directory /etc/polkit-1/rules.d does not exist"
    exit 1
fi

# Read all files in the directory polkit and if the not exit in /etc/polkit-1/rules.d copy them
RESET_POLKIT_SERVICE=false
for file in polkit/*; do
    if sudo test ! -f /etc/polkit-1/rules.d/$(basename $file); then
        echo "Copying $file to /etc/polkit-1/rules.d"
        sudo cp $file /etc/polkit-1/rules.d
        RESET_POLKIT_SERVICE=true
    else
        echo "$(basename $file) already exists in /etc/polkit-1/rules.d"
    fi
done

# Restart polkit
if [ "$RESET_POLKIT_SERVICE" = true ]; then
    echo "Restarting polkit.service"
    #sudo systemctl restart polkit.service
else
    echo "No changes to polkit.service"
fi
