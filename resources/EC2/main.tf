## Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44.0"
    }
  }
}

provider "aws" {
  region = local.aws_region
}



locals {
  aws_region = "us-east-2"
  instance_type = "t2.medium"
  volume_size = 50

  common_tags = {
    "id"             = "2024"
    "name"           = "demo-project-ec2"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "demo-project"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
}

module "EC2" {
  source      = "../../modules/EC2"
  aws_region  = local.aws_region
  common_tags = local.common_tags
  instance_type = local.instance_type
  volume_size = local.volume_size

}