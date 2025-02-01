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
#     key            = "jump-server/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "dev-blueops-jurist-tf-state-lock"
#     encrypt        = true
#   }
# }

locals {
  aws_region         = "us-east-2"
  instance_type      = "t2.micro"
  key_pair           = "jurist"
  key_path           = "~/Downloads/jurist.pem"
  all_traffic        = ["0.0.0.0/0"]
  controlled_traffic = ["10.10.0.0/16"]
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

module "jump-server" {
  source             = "../../modules/jump-server"
  aws_region         = local.aws_region
  instance_type      = local.instance_type
  key_pair           = local.key_pair
  key_path           = local.key_path
  all_traffic        = local.all_traffic
  controlled_traffic = local.controlled_traffic
  common_tags        = local.common_tags
}
