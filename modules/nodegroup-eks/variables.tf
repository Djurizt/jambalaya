variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_version" {
  type = string
}
variable "node_min" {
  type = string
}
variable "desired_node" {
  type = string
}

variable "node_max" {
  type = string
}
variable "blue_node_color" {
  type    = string
}
variable "key_pair" {
  type        = string
}
variable "deployment_nodegroup" {
  type = string
}

variable "capacity_type" {
  type        = string
}
variable "ami_type" {
  type        = string
  description = "Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64"
}
variable "instance_types" {
  type = string
}

variable "disk_size" {
  type = string
}
variable "shared_owned" {
  type        = string
}

variable "enable_cluster_autoscaler" {
  type = bool
}
variable "eks_subnets_ids" {
  type = map(string)
}

variable "common_tags" {
  type = map(any)
}
