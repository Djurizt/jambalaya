
resource "aws_instance" "servers" {
  count                  = 2  
  ami                    = count.index == 0 ? data.aws_ami.ubuntu.id : data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  root_block_device {
    volume_size = 30
  }


  user_data = count.index == 0 ? file("${path.module}/scripts/jenkins_master.sh") : file("${path.module}/scripts/sonarqube.sh")

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-%s", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"],
    count.index == 0 ? "Jenkins-master" : "sonarqube")
  })
}
resource "aws_instance" "jenkins" { 
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
  root_block_device {
    volume_size = var.volume_size
  }


  user_data = file("${path.module}/scripts/jenkins_slave.sh")

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-%s", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"], "jenkins_slave")
  })
}

# resource "aws_instance" "servers" {
#   #count                  = 2  
#   ami                    =  data.aws_ami.ubuntu.id
#   instance_type          = var.instance_type
#   key_name               = var.key_name
#   vpc_security_group_ids = [data.aws_security_group.existing_sg.id]
#   root_block_device {
#     volume_size =  var.volume_size
#   }


#   user_data = file("${path.module}/scripts/custom_server_demo_project.sh") 

#   tags = merge(var.common_tags, {
#     Name = format("%s-%s-%s-%s", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"],
#      "main-server")
#   })
# }
