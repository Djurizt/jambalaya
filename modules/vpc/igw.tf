resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-internet-gateway", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
    },
  )
}
