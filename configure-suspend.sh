#!/bin/bash

# Check if argument [enable, disable] is provided
if [ -z "$1" ]; then
    echo "Please provide the argument [enable, disable]"
    exit 1
fi  

# Check if argument is [enable, disable]
if [ "$1" != "enable" ] && [ "$1" != "disable" ]; then
    echo "Argeument invalid. Please provide [enable, disable]"
    exit 1
fi

# Show status of all modes
show_status() {
    echo "Status of all modes:"
    sudo systemctl status sleep.target suspend.target hibernate.target hybrid-sleep.target
    echo ""
}

show_status

# If argument is enable, enable all modes
if [ "$1" = "enable" ]; then
    echo "Enabling all modes"
    sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
    echo ""
fi

# If argument is disable, disable all modes
if [ "$1" = "disable" ]; then
    echo "Disabling all modes"
    sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
    echo ""
fi

show_status

echo "Done"
