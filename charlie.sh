#!/bin/bash

GREEN="\e[1;32m"
RED="\e[1;31m"
DEFAULT="\e[0m"
VERSION="v.0.0.6"

echo -e "${GREEN}"

cat << "EOF"
  ____ _                _ _      
 / ___| |__   __ _ _ __| (_) ___ 
| |   | '_ \ / _` | '__| | |/ _ \
| |___| | | | (_| | |  | | |  __/
 \____|_| |_|\__,_|_|  |_|_|\___|

EOF
echo "Charlie $VERSION"

if [ -z "$1" ]; then
	echo -e "${RED}Error. Provice a flag (-h for help)." >&2
	exit 1
elif [ "$1" == "-h" ]; then
	echo "---------------------------------------"
	echo "Options for Charlie:"
	echo "-h shows this message"
	echo "-cm changes the MAC address"
	echo "-rm resets to original MAC address"
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
	if [ -z "$2" ]; then
		echo -e "${RED}Error. Enter an IPv4 address for this flag." >&2
		exit 1
	else
		echo -e "Scanning IP address $2...\e[0m"
		sudo nmap -sV -sC -O -Pn -v $2
		echo -e "${GREEN}Done scanning!"
	fi
elif [ "$1" == "-sn" ]; then
	if [ -z "$2" ]; then
		echo -e "${RED}Error. Provide a target IPv4 address."
	else
		echo "Scanning network..."
		echo -e "${DEFAULT}"
		sudo nmap -sn -Pn $target
		echo -e "${GREEN}Done scanning!"
	fi
elif [ "$1" == "-sp" ]; then
	if [ -z "$2" ]; then
		echo -e "${RED}Error. Provide an IPv6 address." >&2
		exit 1
	else
		echo -e "Scanning target...${DEFAULT}"
		sudo nmap -6 -sV -sC -O -Pn -v $2
		echo -e "${GREEN}Done scanning!"
	fi
else
	echo -e "${RED}Error. Flag not recognized." >&22
fi
