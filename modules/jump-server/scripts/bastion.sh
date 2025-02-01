#!/bin/bash

private_ip="${private_ip}"
private_key="${private_key}"
sudo -u ubuntu bash <<EOF
cat > /home/ubuntu/key.pem <<KEYFILE
${private_key}
KEYFILE
chmod 400 /home/ubuntu/key.pem
EOF
sudo apt-get update -y
sudo apt-get install -y nginx
sudo tee /etc/nginx/sites-available/default > /dev/null <<NGINXCONF
server {
    listen 80;
    location / {
        proxy_pass http://${private_ip}:80;
    }
}
NGINXCONF
sudo systemctl reload nginx
