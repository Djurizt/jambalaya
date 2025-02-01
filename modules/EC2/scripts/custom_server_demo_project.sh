#!/bin/bash

# Function to update system packages
update_system() {
  sudo apt update
  sudo apt install -y fontconfig openjdk-17-jre unzip apt-transport-https
}

# Function to install Jenkins
install_jenkins() {
  sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
  echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
  sudo apt-get update -y
  sudo apt-get install jenkins -y
}

# Function to install Docker
install_docker() {
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

# Function to install SonarQube
install_sonarqube() {
  echo "Setting system limits for SonarQube..."
  echo "vm.max_map_count=524288" | sudo tee -a /etc/sysctl.conf
  echo "fs.file-max=131072" | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p

  echo "* soft nofile 131072" | sudo tee -a /etc/security/limits.conf
  echo "* hard nofile 131072" | sudo tee -a /etc/security/limits.conf
  echo "* soft nproc 8192" | sudo tee -a /etc/security/limits.conf
  echo "* hard nproc 8192" | sudo tee -a /etc/security/limits.conf

  echo "Creating Docker network 'sonarnet'..."
  docker network create sonarnet || true

  echo "Running PostgreSQL container..."
  docker run -d --name sonarqube_db --network sonarnet -e POSTGRES_USER=sonar -e POSTGRES_PASSWORD=sonar -e POSTGRES_DB=sonarqube postgres:13

  echo "Running SonarQube container..."
  docker run -d --name sonarqube --network sonarnet -p 9000:9000 -e SONAR_JDBC_URL=jdbc:postgresql://sonarqube_db:5432/sonarqube -e SONAR_JDBC_USERNAME=sonar -e SONAR_JDBC_PASSWORD=sonar sonarqube:community || { echo "SonarQube container failed to start"; exit 1; }
}

# Function to install AWS CLI
install_awscli() {
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  sudo unzip awscliv2.zip
  sudo ./aws/install
}

# Function to install eksctl
install_eksctl() {
  curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/v0.154.0/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
  sudo mv /tmp/eksctl /usr/local/bin
}

# Function to install kubectl
install_kubectl() {
  curl -LO https://dl.k8s.io/release/v1.31.0/bin/linux/amd64/kubectl
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

# Function to install Helm and Grafana Helm charts
install_helm() {
  curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
  sudo apt-get update
  sudo apt-get install -y helm

  helm repo add grafana https://grafana.github.io/helm-charts
  helm repo update
}

# Main script execution
main() {
  update_system
  install_jenkins
  install_docker
  install_sonarqube
  install_awscli
  install_eksctl
  install_kubectl
  install_helm
  echo "All installations completed successfully!"
}

main
