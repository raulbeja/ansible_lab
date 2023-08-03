#!/usr/bin/env bash

ssh-keygen -b 2048 -t rsa -f /home/vagrant/.ssh/id_rsa -q -N ""

for val in master labnode; do 
	sshpass -p 'vagrant' ssh-copy-id -i "/home/vagrant/.ssh/id_rsa" -o "StrictHostKeyChecking=no" vagrant@$val 
done

# Create LABs directory
LABPATH="/home/vagrant/ansible_labs/"
mkdir -p $LABPATH
cd $LABPATH

# Create inventory file
echo -e "master\n\n[labnodes]\nlabnode" > inventory
echo -e "[defaults]\ninventory = inventory" > ansible.cfg
echo

# running adhoc command to see if everything is fine

ansible all -i inventory -m "ping"
echo
