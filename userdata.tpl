#!/bin/bash
sudo apt-get update -y &&
sudo apt-get upgrade -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo apr-get-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu/ $(lsb_release -cs) stable" &&
sudo apt-update -y &&
sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&    
sudo usermod -aG docker ubuntu