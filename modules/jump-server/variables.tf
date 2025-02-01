variable "aws_region" {
  type    = string
}
variable "instance_type" {
  type    = string
}
variable "all_traffic" {
  type    = list(string)
}
variable "controlled_traffic" {
  type    = list(string)
}
variable "key_pair" {
  type    = string
}
variable "common_tags" {
  type = map(any)
}

variable "key_path" {
  type = string
}