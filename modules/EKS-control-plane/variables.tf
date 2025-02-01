variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_version" {
  type = number
}

variable "endpoint_private_access" {
  type = bool
}

variable "endpoint_public_access" {
  type = bool
}

variable "eks_subnet_ids" {
  type = map(string)
}

variable "common_tags" {
  type = map(any)
 
}
