provider "aws" {
  region = local.region
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44.0"
    }
  }
}

# terraform {
#   backend "s3" {
#     bucket         = "dev-blueops-jurist-tf-state"
#     key            = "VPC/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "dev-blueops-jurist-tf-state-lock"
#     encrypt        = true
#   }
# }

locals {
  region       = "us-east-2"
  cluster_name = "dev-jurist-blueops-control-plane"
  cidr_block   = "10.10.0.0/16"
  newbit       = 4
  nat_number   = 2
  availability_zones = [
    "us-east-2a",
    "us-east-2b",
    "us-east-2c"
  ]

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

module "vpc" {
  source             = "../../modules/vpc"
  cidr_block         = local.cidr_block
  cluster_name       = local.cluster_name
  newbit             = local.newbit
  region             = local.region
  availability_zones = local.availability_zones
  nat_number         = local.nat_number
  common_tags        = local.common_tags
}
