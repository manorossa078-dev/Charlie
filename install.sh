#!/bin/bash

readonly REQUIRED=("nmap" "macchanger")
readonly GREEN="\e[1;32m"
readonly YELLOW="\e[1;33m"
readonly RESET="\e[0m"

for tool in "${REQUIRED[@]}"; do
	if [ $? -eq 0 ]; then
		echo -e "${GREEN}[+] Tool $tool already installed installed!"
	else
		echo -e "${YELLOW}Tool $tool not installed. Installing $tool...${RESET}"
		sudo apt install $tool
	fi
done
echo -e "${GREEN}[+] All tools installed!"
