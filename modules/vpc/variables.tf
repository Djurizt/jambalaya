variable "region" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "cidr_block" {
  type        = string
}
variable "cluster_name" {
  type    = string
}

variable "common_tags" {
  type = map(any)
}

variable "nat_number" {
  type    = number
}

variable "newbit" {
  type    = number
}
