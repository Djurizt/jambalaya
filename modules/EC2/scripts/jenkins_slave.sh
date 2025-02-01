#!/bin/bash
set -e  
sudo hostnamectl set-hostname node
sudo apt update
sudo apt install openjdk-17-jdk -y
sudo apt install maven -y
sudo useradd -m jenkins 
sudo -u jenkins mkdir /home/jenkins/.ssh
sudo -u jenkins vi /home/jenkins/.ssh/authorized_keys











