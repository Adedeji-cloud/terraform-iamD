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
