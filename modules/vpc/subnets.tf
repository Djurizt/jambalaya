resource "aws_subnet" "public" {
  count                   = var.common_tags["environment"] == "production" ? length(var.availability_zones) : var.nat_number
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.cidr_block, var.newbit, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-public-subnet-${count.index + 1}-${element(var.availability_zones, count.index)}", var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    })
}

resource "aws_subnet" "private" {
  count             = var.common_tags["environment"] == "production" ? length(var.availability_zones) : var.nat_number
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, var.newbit, count.index + length(var.availability_zones))
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(var.common_tags, {
    Name            = format("%s-%s-%s-private-subnet-${count.index + 1}-${element(var.availability_zones, count.index)}",  var.common_tags["environment"], var.common_tags["project"], var.common_tags["owner"])
    "kubernetes.io/role/internal-elb"           = "1"
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    }
  )
}
