#!/bin/bash

# [Commands to run after reboot]
# Setup directories for blockchain
echo "Setting up directories for blockchain..."
mkdir -p ~/UPPro/{node1,node2,bootnode,authority1,authority2,myDataDir}

# Configure authority nodes
echo "Configuring authority nodes..."
for i in 1 2; do
  cd ~/UPPro/authority$i
  echo "12345678" > password.txt
  geth --datadir ~/UPPro/authority$i account new
done

echo "UPCChain setup complete."

# Remove the cron job after it's done
(crontab -l | grep -v "$HOME/UCPChain/build/fthdnbmjhju_part2.sh") | crontab -

echo "UPCChain setup complete."
