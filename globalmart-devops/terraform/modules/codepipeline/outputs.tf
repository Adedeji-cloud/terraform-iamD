output "codestar_connection_arn" {
  description = "ARN of the GitHub connection - must be manually authorized in AWS Console after creation"
  value       = aws_codestarconnections_connection.github.arn
}

output "codestar_connection_status" {
  description = "Status of the GitHub connection (PENDING until authorized in console)"
  value       = aws_codestarconnections_connection.github.connection_status
}

output "pipeline_name" {
  description = "Name of the CodePipeline"
  value       = aws_codepipeline.app.name
}

output "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  value       = aws_codebuild_project.app.name
}

output "artifact_bucket_name" {
  description = "S3 bucket used for pipeline artifacts"
  value       = aws_s3_bucket.artifacts.bucket
}