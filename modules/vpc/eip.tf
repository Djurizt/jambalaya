resource "aws_eip" "nat_eip" {
  count = var.common_tags["environment"] == "production" ? length(var.availability_zones) : var.nat_number
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-eip-${count.index + 1}-${element(var.availability_zones, count.index)}", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
    },
  )
}
