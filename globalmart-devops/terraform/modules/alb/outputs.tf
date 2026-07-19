output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN of the target group"
  value       = aws_lb_target_group.this.arn
}

output "alb_security_group_id" {
  description = "Security group ID of the ALB"
  value       = aws_security_group.alb.id
}

output "alb_arn_suffix" {
  description = "ARN suffix of the ALB (for CloudWatch dimensions)"
  value       = aws_lb.this.arn_suffix
}
output "target_group_arn_suffix" {
  description = "ARN suffix of the target group (for CloudWatch dimensions)"
  value       = aws_lb_target_group.this.arn_suffix
}
