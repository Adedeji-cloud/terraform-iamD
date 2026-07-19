terraform {
  backend "s3" {
    bucket         = "globmart-terraform-state-142280718160"
    key            = "dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "globmart-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
