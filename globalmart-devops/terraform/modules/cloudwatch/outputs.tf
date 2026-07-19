output "alarm_names" {
  description = "Names of all CloudWatch alarms created"
  value = [
    aws_cloudwatch_metric_alarm.alb_5xx.alarm_name,
    aws_cloudwatch_metric_alarm.alb_unhealthy_hosts.alarm_name,
    aws_cloudwatch_metric_alarm.ecs_running_tasks.alarm_name,
    aws_cloudwatch_metric_alarm.ecs_cpu_high.alarm_name
  ]
}
