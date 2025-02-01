# output "security_group_id" {
#   description = "The ID of the security group allowing SSH."
#   value       = data.aws_security_group.existing_sg.id
# }

# output "bastion_public_ip" {
#   value = aws_instance.servers[0].public_ip
# }

# output "private_instance_private_ip" {
#   value = aws_instance.servers[1].private_ip
# }
