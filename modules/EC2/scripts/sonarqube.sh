#!/bin/bash

set -e

install_sonarqube() {
    echo "Updating system and installing dependencies..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y openjdk-17-jdk curl ca-certificates unzip

    echo "Setting up PostgreSQL repository..."
    sudo install -d /usr/share/postgresql-common/pgdg
    sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
    echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list

    sudo apt update
    sudo apt install postgresql-15 -y
    echo "Creating SonarQube database and user..."
    sudo -u postgres psql <<EOF
CREATE USER sonar WITH ENCRYPTED PASSWORD 'sonar';
CREATE DATABASE sonar OWNER sonar;
EOF

    SONAR_VERSION="sonarqube-25.1.0.102122"
    SONAR_DIR="/opt/sonarqube"

    echo "Downloading and installing SonarQube..."
    wget https://binaries.sonarsource.com/Distribution/sonarqube/${SONAR_VERSION}.zip
    sudo unzip ${SONAR_VERSION}.zip -d /opt/
    sudo mv /opt/${SONAR_VERSION} ${SONAR_DIR}
    rm ${SONAR_VERSION}.zip

    echo "Creating SonarQube user and setting permissions..."
    sudo adduser --system --no-create-home --group --disabled-login sonarqube
    sudo chown -R sonarqube:sonarqube ${SONAR_DIR}

    echo "Configuring SonarQube database settings..."
    sudo tee ${SONAR_DIR}/conf/sonar.properties > /dev/null <<EOF
sonar.jdbc.username=sonar
sonar.jdbc.password=sonar
sonar.jdbc.url=jdbc:postgresql://localhost/sonar
EOF

    echo "Creating SonarQube systemd service..."
    sudo tee /etc/systemd/system/sonarqube.service > /dev/null <<EOF
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=${SONAR_DIR}/bin/linux-x86-64/sonar.sh start
ExecStop=${SONAR_DIR}/bin/linux-x86-64/sonar.sh stop
User=sonarqube
Group=sonarqube
Restart=always
LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
EOF

    echo "Starting SonarQube service..."
    sudo systemctl daemon-reload
    sudo systemctl enable --now sonarqube

    echo "Configuring system limits..."
    sudo tee -a /etc/sysctl.conf > /dev/null <<EOF
vm.max_map_count=524288
fs.file-max=131072
EOF
    sudo sysctl -p

    sudo tee -a /etc/security/limits.conf > /dev/null <<EOF
* soft nofile 131072
* hard nofile 131072
* soft nproc 8192
* hard nproc 8192
EOF

    echo "SonarQube installation and configuration completed successfully!"
}

install_sonarqube

