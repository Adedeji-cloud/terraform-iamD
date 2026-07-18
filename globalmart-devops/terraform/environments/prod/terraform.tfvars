project_name = "globmart"
environment  = "prod"
aws_region   = "eu-west-1"
vpc_cidr     = "10.1.0.0/16"
public_subnets = [
  "10.1.1.0/24",
  "10.1.2.0/24"
]
private_subnets = [
  "10.1.11.0/24",
  "10.1.12.0/24"
]
availability_zones = [
  "eu-west-1a",
  "eu-west-1b"
]
name_prefix = "globmart-prod"
common_tags = {
  Project     = "globmart"
  Environment = "prod"
}
github_owner = "Adedeji-cloud"
github_repo  = "terraform-iamD"