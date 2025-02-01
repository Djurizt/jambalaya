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
  aws_region   = "us-east-2"
  cluster_name = "dev-jurist-blueops-control-plane"
  eks_version  = "1.31"
  node_min     = "1"
  desired_node = "1"
  node_max     = "6"

  key_pair                  = "jurist"
  deployment_nodegroup      = "blue_green"
  blue_node_color           = "blue"
  capacity_type             = "ON_DEMAND"
  ami_type                  = "AL2_x86_64"
  instance_types            = "t2.medium"
  disk_size                 = "10"
  shared_owned              = "shared"
  enable_cluster_autoscaler = true
  common_tags = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }

  eks_subnets_ids = {
    us-east-2a = "subnet-0a355d84a4e4bfe4c"
    us-east-2b = "subnet-0ed04ad98d19f0578"
    us-east-2c = "subnet-00d462ac31a53945b"
  }
}
module "Nodegroup" {
  source                    = "../../modules/nodegroup-eks"
  aws_region                = local.aws_region
  cluster_name              = local.cluster_name
  eks_version               = local.eks_version
  node_min                  = local.node_min
  desired_node              = local.desired_node
  node_max                  = local.node_max
  eks_subnets_ids           = local.eks_subnets_ids
  key_pair                  = local.key_pair
  deployment_nodegroup      = local.deployment_nodegroup
  blue_node_color           = local.blue_node_color
  capacity_type             = local.capacity_type
  ami_type                  = local.ami_type
  instance_types            = local.instance_types
  disk_size                 = local.disk_size
  shared_owned              = local.shared_owned
  enable_cluster_autoscaler = local.enable_cluster_autoscaler
  common_tags               = local.common_tags
}