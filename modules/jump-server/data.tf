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

# data "template_file" "bastion_script" {
#   template = file("${path.module}/scripts/bastion.sh")

#   vars = {
#     private_key = base64decode(jsondecode(data.aws_secretsmanager_secret_version.key.secret_string).key)
#     private_ip = aws_instance.private_instance.private_ip
#   }
# }

# data "aws_secretsmanager_secret" "key" {
#   name = "key-pair"
# }

# data "aws_secretsmanager_secret_version" "key" {
#   secret_id = data.aws_secretsmanager_secret.key.id
# }

data "aws_subnet" "public" {
  filter {
    name   = "tag:Name"
    values = ["dev-blueops-jurist-public-subnet-1-us-east-2a"]
  }
}

# data "aws_subnet" "private" {
#   filter {
#     name   = "tag:Name"
#     values = ["dev-blueops-jurist-private-subnet-1-us-east-2a"]
#   }
# }

data "aws_vpc" "vpc" {
  filter {
    name   = "is-default"
    values = ["false"]
  }

  filter {
    name   = "tag:environment"
    values = ["dev"]
  }
}
# data "aws_subnets" "public" {
#   filter {
#     name   = "tag:Name"
#     values = ["*-public-*"]
#   }
#   filter {
#     name   = "tag:environment"
#     values = ["dev"]
#   }
#   filter {
#     name   = "availability-zone"
#     values = ["us-east-2a", "us-east-2b", "us-east-2c"]
#   }
# }

# data "aws_subnets" "private" {
#   filter {
#     name   = "tag:Name"
#     values = ["*-private-*"]
#   }
#   filter {
#     name   = "tag:environment"
#     values = ["dev"]
#   }
#   filter {
#     name   = "availability-zone"
#     values = ["us-east-2a", "us-east-2b", "us-east-2c"]
#   }
# }
