variable "project_name" {}

variable "environment" {}

variable "aws_region" {}

variable "vpc_cidr" {}

variable "public_subnets" {}

variable "private_subnets" {}

variable "availability_zones" {}
variable "name_prefix" {
  description = "Naming prefix for resources"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}

variable "github_owner" {
  description = "GitHub organization or username that owns the repo"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
}