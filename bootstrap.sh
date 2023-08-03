#!/usr/bin/env bash

# Enable ssh password authentication 
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

# Install common software
sudo apt update && sudo apt -y install curl wget net-tools iputils-ping python3-pip sshpass

# Install ansible on master
if [[ $(hostname) = "master" ]]; then
  sudo pip3 install ansible
fi

# Update hosts file with vagrantfile nodes IP
echo -e "192.168.56.10 master master\n192.168.56.20 labnode labnode" >> /etc/hosts


