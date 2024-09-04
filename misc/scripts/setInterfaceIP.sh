#!/bin/bash

INTERFACE_NAME='enx00e04c706cc3'

sudo ip link set $INTERFACE_NAME down
sleep 3
sudo ip addr del 192.168.3.101/24 dev $INTERFACE_NAME
sudo ip addr del 169.254.3.101/16 dev $INTERFACE_NAME
sleep 3
sudo ip addr add 192.168.3.101/24 dev $INTERFACE_NAME
sudo ip addr add 169.254.3.101/16 dev $INTERFACE_NAME
sleep 3
sudo ip link set $INTERFACE_NAME up
