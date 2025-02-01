data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_security_group" "existing_sg" {
  name = "jurist"
}

# data "aws_ami" "my_existing_ami" {
#   most_recent = true
#   owners      = ["self"] # Replace with the owner ID or use "amazon" for official AMIs

#   # Optional filter if looking for a specific AMI name
#   filter {
#     name   = "tag:Name" 
#     values = ["demo-project-instance-*"] # Replace with the name pattern for the AMI
#   }

# }