# terraform {
#   backend "s3" {
#     bucket         = "dev-jurist-demo-project-tf-state"
#     key            = "AWSAuthConfig/terraform.tfstate"
#     region         = "us-east-2"
#     dynamodb_table = "dev-jurist-demo-project-tf-state-lock"
#     encrypt        = true
#   }
# }