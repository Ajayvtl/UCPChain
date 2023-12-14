#!/bin/bash

# Update and install necessary packages
sudo apt update
sudo apt upgrade -y
sudo apt install software-properties-common -y

# Configure the firewall
sudo ufw status
sudo ufw allow 8545/tcp && sudo ufw allow 30303/tcp && sudo ufw allow 30303/udp && sudo ufw allow 8546/tcp && sudo ufw allow 8547/tcp && sudo ufw allow 30301/tcp && sudo ufw allow 30301/udp
sudo ufw status
sudo ufw reload

# Add Ethereum repository and install Geth
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt update
sudo apt install ethereum -y

# Reboot system
sudo apt update
sudo reboot

# Setup directories for blockchain
mkdir -p ~/UPPro/{node1,node2,bootnode,authority1,authority2,myDataDir}

# Configure authority nodes
for i in 1 2; do
  cd ~/UPPro/authority$i
  echo "12345678" > password.txt
  geth --datadir ~/UPPro/authority$i account new
done
