# resource "aws_launch_template" "eks_nodes" {
#   name = format("%s-%s-%s-ec2", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
#   image_id      = data.aws_ami.ubuntu.id
#   instance_type = var.instance_types
#   key_name = var.key_pair  
#   block_device_mappings {
#     device_name = "/dev/xvda"

#     ebs {
#       volume_size = var.disk_size
#       volume_type = "gp3"
#     }
#   }


#   tag_specifications {
#     resource_type = "instance"

#     tags = merge(var.common_tags, {
#       Name = format("%s-%s-%s-nodes", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
#     })
#   }
# }


# # resource "aws_launch_template" "eks_nodes" {
# #   name = format("%s-%s-%s-ec2", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])

# #   image_id      = data.aws_ami.ubuntu.id
# #   instance_type = var.instance_types
# #   key_name      = var.key_pair

# #     block_device_mappings {
# #     device_name = "/dev/xvda"

# #     ebs {
# #       volume_size = var.disk_size
# #       volume_type = "gp3"
# #     }
# #   }

# #   tag_specifications {
# #     resource_type = "instance"

# #     tags = merge(var.common_tags, {
# #       Name = format("%s-%s-%s-nodes", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
# #     })
# #   }
# # }