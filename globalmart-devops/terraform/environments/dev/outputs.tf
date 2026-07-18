output "vpc_id" {

  description = "ID of the GlobalMart VPC"

  value = module.vpc.vpc_id

}

output "public_subnet_ids" {

  description = "IDs of the public subnets"

  value = module.vpc.public_subnet_ids

}

output "private_subnet_ids" {

  description = "IDs of the private subnets"

  value = module.vpc.private_subnet_ids

}

output "internet_gateway_id" {

  description = "Internet Gateway ID"

  value = module.vpc.internet_gateway_id

}

output "nat_gateway_id" {

  description = "NAT Gateway ID"

  value = module.vpc.nat_gateway_id

}
output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = module.ecr.repository_url
}
output "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  value       = module.ecr.repository_arn
}
output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = module.ecr.repository_name
}

output "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  value       = module.iam.ecs_task_execution_role_arn
}
output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = module.iam.ecs_task_role_arn
}
output "ecs_task_role_name" {
  description = "Name of the ECS task role"
  value       = module.iam.ecs_task_role_name
}

output "alb_dns_name" {
  description = "DNS name of the ALB (use this to access the app)"
  value       = module.alb.alb_dns_name
}
output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb.alb_arn
}
output "alb_target_group_arn" {
  description = "ARN of the ALB target group (used by ECS service)"
  value       = module.alb.target_group_arn
}
output "alb_security_group_id" {
  description = "Security group ID of the ALB"
  value       = module.alb.alb_security_group_id
}
