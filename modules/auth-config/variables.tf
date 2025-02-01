variable "aws_region" {
  type    = string
}

variable "user_arn" {
  type    = string
}
variable "username" {
  type    = string
}
variable "role_arn" {
  type    = string
}
variable "common_tags" {
  type = map(any)
}