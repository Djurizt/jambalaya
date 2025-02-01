resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-public-route-table", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
    },
  )
}

resource "aws_route_table_association" "public" {
  count = var.common_tags["environment"] == "production" ? length(var.availability_zones) : var.nat_number
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table" "private" {
  count  = var.common_tags["environment"] == "production" ? length(var.availability_zones) : var.nat_number
  vpc_id = aws_vpc.main.id
  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-private-route-table-${count.index + 1}-${element(var.availability_zones, count.index)}", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
    },
  )
}

resource "aws_route" "nat_gateway" {
  count                  = var.common_tags["environment"] == "production" ? length(var.availability_zones) : var.nat_number
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.main.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = var.common_tags["environment"] == "production" ? length(var.availability_zones) : var.nat_number
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
