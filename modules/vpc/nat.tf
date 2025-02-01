resource "aws_nat_gateway" "main" {
  count         = var.common_tags["environment"] == "production" ? length(var.availability_zones) : var.nat_number
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-nat-${count.index + 1}-${element(var.availability_zones, count.index)}",  var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
    }
  )
}
