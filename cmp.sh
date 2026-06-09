#!/bin/bash

GREEN="\e[1;32m"
RED="\e[1;31m"
VERSION="v.0.0.6"
DEFAULT="\e[0m"

echo -e "${GREEN}"

cat << "EOF"
  ____ __  __ ____
 / ___|  \/  |  _ \
| |   | |\/| | |_) |
| |___| |  | |  __/
 \____|_|  |_|_|
EOF
echo "Charlie $VERSION"

if [ -z "$1" ]; then
	echo -e "${RED}Error. Provice a flag (-h for help)." >&2
	exit 1
elif [ "$1" == "-h" ]; then
	echo "---------------------------------------"
	echo "Options for Charlie:"
	echo "-h shows this message"
	echo "-cm changes the MAC address (Could not work on any device)"
	echo "-rm resets to original MAC address (Could not work on any device)"
	echo "-st scans a target"
	echo "-sn scans a network"
	echo "-sp to scan a phone"
	echo "---------------------------------------"
elif [ "$1" == "-cm" ]; then
	read -p "Enter an interface: " interface
	echo "Changing MAC..."
	sudo ip link set dev $interface down
	sudo macchanger -m 02:AA:BB:CC:DD:EE $interface
	sudo ip link set dev $interface up
	echo "MAC changed!"
elif [ "$1" == "-rm" ]; then
	read -p "Enter an interface: " interface
	sudo ip link set dev $interface down
	sudo macchanger -p $interface
	sudo ip link set dev $interface up
elif [ "$1" == "-st" ]; then
	read -p "Enter a target IP: " target
	echo -e "Scanning IP address $target..${DEFAULT}"
	nmap -sV -sC -Pn -v $target
	echo -e "${GREEN}Done scanning!"
elif [ "$1" == "-sn" ]; then
	read -p "Enter the target IP: " target
	echo "Scanning network..."
	echo -e "${DEFAULT}"
	nmap -sn -Pn $target
	echo -e "${GREEN}Done scanning!"
elif [ "$1" == "-sp" ]; then
	read -p "Enter an IPv6 address: " target
	echo -e "Scanning $target...${DEFAULT}"
	nmap -6 -sV -sC -Pn -v $target
	echo -e "${GREEN}Scan finished!"
else
	echo -e "${RED}Error. Flag not recognized." >&2
fi
