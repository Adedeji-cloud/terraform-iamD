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