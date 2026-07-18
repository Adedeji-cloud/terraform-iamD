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

variable "github_branch" {
  description = "Branch to trigger the pipeline on"
  type        = string
  default     = "main"
}

variable "ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
}

variable "ecr_repository_arn" {
  description = "ARN of the ECR repository"
  type        = string
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  type        = string
}

variable "ecs_service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "container_name" {
  description = "Name of the container in the ECS task definition (must match)"
  type        = string
}

variable "ecs_task_execution_role_arn" {
  description = "ARN of the ECS task execution role (for PassRole permission)"
  type        = string
}

variable "ecs_task_role_arn" {
  description = "ARN of the ECS task role (for PassRole permission)"
  type        = string
}

variable "buildspec_path" {
  description = "Path to the buildspec.yml file relative to repo root"
  type        = string
  default     = "globalmart-devops/app/buildspec.yml"
}