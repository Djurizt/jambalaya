variable "aws_region" {
  type    = string
  default = "us-east-2"
}
variable "docker_script" {
  type = string
  default = "./scripts/docker.sh"
}
variable "docker_sonar_script" {
  type = string
  default = "./scripts/docker_sonar.sh"
}

variable "jenkins_master_script" {
  type = string
  default = "./scripts/jenkins_master.sh"
}

variable "jenkins_slave_script" {
  type = string
  default = "./scripts/jenkins_slave.sh"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "jurist"
}
variable "force_destroy" {
  type    = bool
  default = true
}
variable "volume_size"{
  type = number
  default = 8
}
variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "name"           = "blueops-ec2"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
}
