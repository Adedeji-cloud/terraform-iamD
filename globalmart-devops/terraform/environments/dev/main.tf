module "vpc" {
  source = "../../modules/vpc"

  name_prefix        = var.name_prefix
  common_tags        = var.common_tags
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}
module "ecr" {
  source = "../../modules/ecr"

  name_prefix     = var.name_prefix
  common_tags     = var.common_tags
  repository_name = "app"
}
