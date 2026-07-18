variable "name_prefix" {
  description = "Naming prefix for resources"
  type        = string
}

variable "common_tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "aws_region" {
  description = "AWS region (used for log configuration)"
  type        = string
}

variable "ecr_repository_url" {
  description = "URL of the ECR repository"
  type        = string
}

variable "image_tag" {
  description = "Image tag to deploy"
  type        = string
  default     = "latest"
}

variable "task_execution_role_arn" {
  description = "ARN of the ECS task execution role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN of the ECS task role"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security group ID of the ALB (for ingress rule)"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group"
  type        = string
}

variable "app_port" {
  description = "Port the application container listens on"
  type        = number
  default     = 3000
}

variable "task_cpu" {
  description = "CPU units for the Fargate task (256 = .25 vCPU)"
  type        = string
  default     = "256"
}

variable "task_memory" {
  description = "Memory (MB) for the Fargate task (512 = 0.5GB)"
  type        = string
  default     = "512"
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 1
}
