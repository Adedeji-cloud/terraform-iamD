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

module "ecs" {
  source = "../../modules/ecs"

  name_prefix             = var.name_prefix
  common_tags             = var.common_tags
  vpc_id                  = module.vpc.vpc_id
  private_subnet_ids      = module.vpc.private_subnet_ids
  aws_region              = var.aws_region
  ecr_repository_url      = module.ecr.repository_url
  task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  task_role_arn           = module.iam.ecs_task_role_arn
  alb_security_group_id   = module.alb.alb_security_group_id
  target_group_arn        = module.alb.target_group_arn
  app_port                = 3000
  task_cpu                = "256"
  task_memory             = "512"
  desired_count           = 1
}
