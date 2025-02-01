# #!/bin/bash
# private_ip = ${private_ip}
# sudo -u ubuntu bash <<EOF
# cat <<KEYFILE > /home/ubuntu/key.pem
# ${private_key}
# KEYFILE
# chmod 400 /home/ubuntu/key.pem
# EOF
# sudo apt-get update -y
# sudo apt-get install -y nginx
# echo "server {
#       listen 80;
#       location / {
#         proxy_pass http://${private_ip}:80;
#       }
#     }" | sudo tee /etc/nginx/sites-available/default

# sudo systemctl reload nginx