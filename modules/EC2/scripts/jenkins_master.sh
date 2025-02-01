#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

function install_jenkins() {
   
    sudo apt-get update -y
    sudo apt-get -f install
    sudo apt-get install -y curl wget gnupg openjdk-17-jdk
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y jenkins

    sudo systemctl start jenkins
    sudo systemctl enable jenkins
    echo "Checking Jenkins status..."
    sudo systemctl status jenkins
}

function install_docker() {
  sudo apt-get remove -y docker docker-engine docker.io containerd runc
  sudo apt-get update -y
  sudo apt-get -f install -y
  sudo apt-get install -y ca-certificates curl gnupg

  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get update -y

  VERSION_STRING="5:27.0.1-1~ubuntu.22.04~jammy"
  sudo apt-get install -y docker-ce=$VERSION_STRING docker-ce-cli=$VERSION_STRING containerd.io docker-buildx-plugin docker-compose-plugin

  sudo systemctl start docker
  sudo systemctl enable docker

  sudo docker run hello-world || { echo "Docker installation failed"; exit 1; }
}

# Execute the Jenkins installation function
install_jenkins
install_docker
