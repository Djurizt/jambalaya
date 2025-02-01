# # resource "aws_vpc" "main" {
# #   cidr_block = "10.0.0.0/16"
# # }

# # resource "aws_subnet" "public" {
# #   vpc_id            = aws_vpc.main.id
# #   cidr_block        = "10.0.1.0/24"
# #   map_public_ip_on_launch = true
# #   availability_zone = "us-east-2a"
# # }

# # resource "aws_subnet" "private" {
# #   vpc_id            = aws_vpc.main.id
# #   cidr_block        = "10.0.2.0/24"
# #   availability_zone = "us-east-2a"
# # }

# # resource "aws_internet_gateway" "igw" {
# #   vpc_id = aws_vpc.main.id
# # }

# # resource "aws_route" "public_route" {
# #   route_table_id         = aws_vpc.main.main_route_table_id
# #   destination_cidr_block = "0.0.0.0/0"
# #   gateway_id             = aws_internet_gateway.igw.id
# # }

resource "aws_security_group" "bastion_sg" {
  vpc_id = data.aws_vpc.vpc.id
  name = "bastion-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.all_traffic
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.all_traffic 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.all_traffic
  }
}


# resource "aws_security_group" "private_instance_sg" {
#   vpc_id = data.aws_vpc.vpc.id

#   ingress {
#     from_port       = 22
#     to_port         = 22
#     protocol        = "tcp"
#     #security_groups = var.all_traffic
#     cidr_blocks = var.all_traffic
#   }
#   ingress {
#     from_port         = 80
#     to_port           = 80
#     protocol          = "tcp"
#     #security_groups = var.all_traffic
#     cidr_blocks = var.all_traffic
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = var.all_traffic
#   }
# }