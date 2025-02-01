# #!/bin/bash

# sudo apt update
# sudo apt upgrade -y
# sudo apt install openjdk-17-jdk -y

# sudo apt install curl ca-certificates
# sudo install -d /usr/share/postgresql-common/pgdg
# sudo curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
# sudo sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# sudo apt update
# sudo apt install postgresql-15 -y

# sudo -i -u postgres
# createuser sonar
# createdb sonar -O sonar
# psql

# ALTER USER sonar WITH ENCRYPTED PASSWORD 'sonar';
# \q
# exit

# wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-sonarqube-25.1.0.102122.zip
# sudo apt install unzip -y
# unzip sonarqube-25.1.0.102122.zip
# sudo mv sonarqube-25.1.0.102122.zip /opt/sonarqube

# sudo adduser --system --no-create-home --group --disabled-login sonarqube
# sudo chown -R sonarqube:sonarqube /opt/sonarqube

# sudo vim /opt/sonarqube/conf/sonar.properties
# set sonar.jdbc.username=sonar
# sonar.jdbc.password=sonar
# sonar.jdbc.url=jdbc:postgresql://localhost/sonar


# sudo vim /etc/systemd/system/sonarqube.service
# add the content [Unit]
# Description=SonarQube service
# After=syslog.target network.target

# [Service]
# Type=forking

# ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
# ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop

# User=sonarqube
# Group=sonarqube
# Restart=always

# LimitNOFILE=65536
# LimitNPROC=4096

# [Install]
# WantedBy=multi-user.target

# sudo systemctl daemon-reload
# sudo systemctl start sonarqube
# sudo systemctl enable sonarqube

# echo "vm.max_map_count=524288" | sudo tee -a /etc/sysctl.conf
# echo "fs.file-max=131072" | sudo tee -a /etc/sysctl.conf
# sudo sysctl -p
# echo "* soft nofile 131072" | sudo tee -a /etc/security/limits.conf
# echo "* hard nofile 131072" | sudo tee -a /etc/security/limits.conf
# echo "* soft nproc 8192" | sudo tee -a /etc/security/limits.conf
# echo "* hard nproc 8192" | sudo tee -a /etc/security/limits.conf

