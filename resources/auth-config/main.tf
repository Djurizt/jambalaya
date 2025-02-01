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

locals {
  aws_region = "us-east-2"
  role_arn = "arn:aws:iam::494597675232:role/dev-jurist-blueops-nodegroup-role"
  user_arn =  "arn:aws:iam::713881795316:root"
  username = "root"
  common_tags = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
}

module "aws-auth-config" {
  source             = "../../modules/auth-config"
  aws_region         = local.aws_region
  user_arn           = local.user_arn
  username           = local.username
  role_arn           = local.role_arn
  common_tags        = local.common_tags
}