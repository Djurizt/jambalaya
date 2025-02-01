# Create a security group to allow SSH
/*resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-07f4531a8062c6a78"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Add tags to the security group
  tags = {
    Create_By   = "Terraform"
    Environment = "Dev"
    Project     = "Beta"
    Company     = "DEL"
  }
}*/