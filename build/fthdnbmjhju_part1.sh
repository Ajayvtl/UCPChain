#!/bin/bash

# Display welcome message and graphic
echo "**************************************************"
echo "                   UPCChain                       "
echo "         Developed by Arya Community              "
echo "**************************************************"

# Ask for installation confirmation
read -p "Do you want to install UPCChain? (Y/N): " confirm_install
if [[ $confirm_install != "Y" && $confirm_install != "y" ]]; then
    echo "Installation cancelled."
    exit 1
fi

# Display system information
echo "Gathering system information..."
echo "Operating System: $(lsb_release -d | cut -f2)"
echo "Hardware Details: $(lscpu | grep 'Model name')"
echo "**************************************************"

# Ask to continue
read -p "Continue with installation? (Y/N): " confirm_continue
if [[ $confirm_continue != "Y" && $confirm_continue != "y" ]]; then
    echo "Installation cancelled."
    exit 1
fi

# Update and install necessary packages
echo "Updating and installing necessary packages..."
sudo apt update
sudo apt upgrade -y
sudo apt install software-properties-common -y

# Configure the firewall
echo "Configuring the firewall..."
sudo ufw status
sudo ufw allow 8545/tcp && sudo ufw allow 30303/tcp && sudo ufw allow 30303/udp && sudo ufw allow 8546/tcp && sudo ufw allow 8547/tcp && sudo ufw allow 30301/tcp && sudo ufw allow 30301/udp
sudo ufw status
sudo ufw reload

# Add Arya repository and install
echo "Adding Arya repository and installing..."
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt update
sudo apt install ethereum -y
# Add a cron job to continue with the second part after reboot
(crontab -l 2>/dev/null; echo "@reboot $HOME/UCPChain/build/fthdnbmjhju_part2.sh") | crontab -

# Reboot system
echo "System will now reboot to complete installation."
sudo apt update
sudo reboot

