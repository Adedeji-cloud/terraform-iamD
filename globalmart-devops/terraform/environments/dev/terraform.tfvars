project_name = "globmart"

environment = "dev"

aws_region = "eu-west-1"

vpc_cidr = "10.0.0.0/16"

public_subnets = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnets = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

availability_zones = [
  "eu-west-1a",
  "eu-west-1b"
]
name_prefix = "globmart-dev"
common_tags = {
  Project     = "globmart"
  Environment = "dev"
}

github_owner = "Adedeji-cloud"
github_repo = "terraform-iamD"