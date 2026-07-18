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

module "iam" {
  source = "../../modules/iam"

  name_prefix = var.name_prefix
  common_tags = var.common_tags
}

module "alb" {
  source = "../../modules/alb"

  name_prefix       = var.name_prefix
  common_tags       = var.common_tags
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  target_port       = 3000
  health_check_path = "/"
}
