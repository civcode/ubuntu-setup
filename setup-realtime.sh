#!/bin/bash

# Check if group realtime exists
if ! getent group realtime; then
    echo "Creating group realtime"
    sudo groupadd realtime
else
    echo "Group realtime already exists"
fi

# Check if user is in group realtime
# If not, add user to group realtime
if ! groups | grep -q realtime; then
    echo "Adding user to group realtime"
    sudo usermod -a -G realtime $USER
else
    echo "User is already in group realtime"
fi

# Update security limits
# Check if /etc/security/limits.conf exits
# If it does not, exit
# If it does, check if the limits are already set
# If they are not, set them
# If they are, do nothing
if [ ! -f /etc/security/limits.conf ]; then
    echo "File /etc/security/limits.conf does not exist"
    exit 1
fi

# Get the first three lines of realtime/mylimits.conf and check if they are already in /etc/security/limits.conf
# If they are not, add realtime/mylimits.conf just before # End of file
# If they are, do nothing
CHANGED_FILE=false
mylimits_header=$(head -n 3 realtime/mylimits.conf)
if ! grep -Fxq "$mylimits_header" /etc/security/limits.conf; then
    echo "Adding realtime/mylimits.conf to /etc/security/limits.conf"
    # Save the current IFS (Internal Field Separator)
    OLDIFS=$IFS
    # Set IFS to newline to handle each line as a separate entity
    IFS=$'\n'
    # Add realtime/mylimits.conf just before the line that says # End of file
    for line in $(cat realtime/mylimits.conf); do
        sudo sed -i "/# End of file/i $line" /etc/security/limits.conf 
    done
    IFS=$OLDIFS
    sudo sed -i '$i\\' /etc/security/limits.conf
    CHANGED_FILE=true
else
    echo "Settings from realtime/mylimits.conf are already in /etc/security/limits.conf"
fi

# Show the last lines of /etc/security/limits.conf
if [ "$CHANGED_FILE" = true ]; then
    echo ""
    echo "Check the changes in /etc/security/limits.conf"
    echo ".............................................."
    tail -n 20 /etc/security/limits.conf
    echo ".............................................."
    echo ""
fi

echo "Done"