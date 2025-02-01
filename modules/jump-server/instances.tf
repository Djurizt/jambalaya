resource "aws_instance" "bastion" {
  # depends_on = [aws_instance.private_instance]
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  # subnet_id              = data.aws_subnet.public.id
  subnet_id              = data.aws_subnet.public.id 
  key_name               = var.key_pair
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]
  # vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  #user_data = data.template_file.bastion_script.rendered
  
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-%s", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"],
    "public-ec2")
  })
}

# resource "aws_instance" "private_instance" {
#   ami                    = data.aws_ami.ubuntu.id
#   instance_type          = var.instance_type
#   subnet_id              = data.aws_subnet.private.id
#   key_name               = var.key_pair
#   vpc_security_group_ids = [aws_security_group.private_instance_sg.id]
#   #user_data =  file("${path.module}/scripts/voguepay.sh")

#   tags = merge(var.common_tags, {
#     Name = format("%s-%s-%s-%s", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"],
#     "private-ec2")
#   })
# }
# resource "null_resource" "apache_install" {
#   depends_on = [aws_instance.bastion, aws_instance.private_instance]

#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get update -y",                                  
#       "sudo apt-get install -y apache2",                          
#       "sudo systemctl start apache2",                             
#       "sudo systemctl enable apache2",                            
#       "echo 'Hello from Apache' | sudo tee /var/www/html/index.html", 
#       "sudo apt-get install -y nginx",
#       "sudo systemctl start nginx",                             
#       "sudo tee /etc/nginx/sites-available/default > /dev/null <<EOF",
#       "server {",
#       "    listen 80;",
#       "    location / {",
#       "        proxy_pass http://${aws_instance.private_instance.private_ip}:80;",
#       "    }",
#       "}",
#       "EOF",
#       "sudo systemctl reload nginx"
#       # "sudo nginx -t"
#       # "scp -i ~/Downloads/jurist.pem ~/Downloads/jurist.pem ubuntu@${aws_instance.private_instance.private_ip}:/home/ubuntu/",
#       # "ssh -o StrictHostKeyChecking=no -f -N -D 1080 -i /home/ubuntu/.ssh/id_rsa ubuntu@${aws_instance.bastion.public_ip}"
#     ]

#     connection {
#       host        = aws_instance.private_instance.private_ip  
#       user        = "ubuntu"                                   
#       private_key = file(var.key_path)                          
#       bastion_host = aws_instance.bastion.public_ip            
#       bastion_user = "ubuntu"                                  
#       bastion_private_key = file(var.key_path)                  
#       timeout     = "2m"
#     }
#   }
# }




