\# GlobalMart DevOps Infrastructure



Terraform-managed AWS infrastructure for a containerized e-commerce app, with full CI/CD via CodePipeline. Two isolated environments (`dev`, `prod`), each independently deployable from separate git branches.



\## Architecture
GitHub (main/prod branch)

│

▼

CodeStar Connection ──► CodePipeline

│

┌───────────┼───────────┐

▼           ▼           ▼

Source ──►  CodeBuild ──► ECS Deploy

(Docker      (rolling

build,       update)

push to

ECR)

│

▼

ECS Fargate Service

│

▼

Application Load Balancer

│

▼

Internet


\*\*Per environment:\*\*

\- \*\*VPC\*\* — 2 public + 2 private subnets across 2 AZs, single NAT Gateway, Internet Gateway

\- \*\*ECR\*\* — private Docker registry, `IMMUTABLE` tag policy, lifecycle rule expiring untagged images after 14 days and keeping only the last 10 tagged images

\- \*\*ECS Fargate\*\* — 1 task by default, behind an ALB, rolling deployments (200% max / 100% min healthy)

\- \*\*ALB\*\* — HTTP on port 80; HTTPS on 443 is conditional on a real ACM `certificate\_arn` being supplied (empty string disables it and falls back to plain HTTP forwarding)

\- \*\*CodePipeline\*\* — Source (GitHub via CodeStar Connection) → Build (CodeBuild, Docker) → Deploy (ECS)

\- \*\*CloudWatch + SNS\*\* — ECS CPU/running-task alarms, ALB 5xx/unhealthy-host alarms, email notification topic

\- \*\*IAM\*\* — dedicated least-privilege roles for CodeBuild, CodePipeline, and ECS tasks (task role + execution role)



\## Environments



| | dev | prod |

|---|---|---|

| VPC CIDR | `10.0.0.0/16` | `10.1.0.0/16` |

| Git branch watched | `main` | `prod` |

| Resource prefix | `globmart-dev-\*` | `globmart-prod-\*` |



Environments are fully isolated — separate VPCs, separate ECR repos, separate pipelines. Promoting a change to prod means merging `main` into `prod` and pushing.



\## Remote State



Both environments use an S3 backend with DynamoDB locking:

\- Bucket: `globmart-terraform-state-142280718160` (versioned, encrypted, public access blocked)

\- Lock table: `globmart-terraform-locks`

\- State paths: `dev/terraform.tfstate`, `prod/terraform.tfstate`



This bucket and table are bootstrap infrastructure — created manually once via AWS CLI, not managed by Terraform itself (chicken-and-egg problem: the backend config can't live inside the state it's storing).



\## Setup



```powershell

cd globalmart-devops/terraform/environments/<dev|prod>

terraform init

terraform plan

terraform apply

```



After first apply, two manual one-time steps:

1\. \*\*Authorize the GitHub connection\*\* — it's created in `PENDING` status. Go to CodePipeline → Settings → Connections in the AWS Console, select the connection, click "Update pending connection," and authorize via the AWS Connector for GitHub app (must have access to the `terraform-iamD` repo).

2\. \*\*Confirm the SNS email subscription\*\* — check your inbox for the AWS subscription confirmation.



\## Tearing down (cost control)



Both environments run a NAT Gateway (\~$30+/month each) and ALB (\~$16-20/month each) continuously once applied — the two biggest cost drivers. To stop billing between work sessions:



```powershell

\# Empty the pipeline artifact bucket first (versioned buckets block destroy otherwise)

aws s3 rm s3://globmart-<env>-pipeline-artifacts-<account-id> --recursive --region eu-west-1



\# Force-delete the ECR repo (blocks destroy if it still has images)

aws ecr delete-repository --repository-name globmart-<env>-app --region eu-west-1 --force



terraform destroy

```



`terraform apply` fully rebuilds either environment from scratch afterward — remote state and the S3/DynamoDB backend persist independently of the destroyed environment resources.



\## Gotchas / lessons learned



Real issues hit building this, kept here so future-me doesn't rediscover them the hard way:



\- \*\*S3 bucket deletion with versioning enabled\*\*: `aws s3 rm --recursive` only adds delete markers, it doesn't remove old versions. `terraform destroy` will fail with `BucketNotEmpty` until every version \*and\* delete marker is explicitly deleted via `aws s3api delete-object --version-id`.

\- \*\*ECR tag immutability + CI re-runs\*\*: image tags are derived from the git commit SHA. Re-triggering a pipeline run without a new commit reuses the same SHA → same tag → fails to push against an `IMMUTABLE` repo. This is expected, not a bug — one push should mean one release.

\- \*\*IAM PassRole for ECS deploy needs two service principals\*\*: CodePipeline's ECS deploy action requires `iam:PassRole` with `iam:PassedToService` matching \*\*both\*\* `ecs.amazonaws.com` and `ecs-tasks.amazonaws.com` (as a list under `StringEquals`), not just `ecs-tasks.amazonaws.com` alone. Missing the first one surfaces as a vague "insufficient permissions" error with no specific action named.

\- \*\*`ecs:TagResource` for task definitions with tags\*\*: if the ECS task definition has tags, `RegisterTaskDefinition` propagates them, which needs `ecs:TagResource` explicitly granted — otherwise, same vague permissions error as above.

\- \*\*Region isn't inherited from parent directories\*\*: each `environments/<env>/` folder is its own Terraform root module. A `provider.tf` sitting in a shared parent folder does nothing — it must exist inside each environment folder, or the AWS provider silently falls back to the CLI's default region (which may not match where your resources actually need to live).

\- \*\*HTTPS ALB listener needs a real ACM cert\*\*: the `https` listener is conditional (`count = var.certificate\_arn != "" ? 1 : 0`) — with no certificate, only the HTTP listener is created and forwards directly (no redirect loop to a nonexistent HTTPS listener).

\- \*\*Windows filename case/spelling sensitivity for Terraform\*\*: `variable.tf` vs `variables.tf`, `provider.tf` vs `providers.tf` — Terraform loads any `.tf` file in a directory regardless of name, but copying an environment folder with `Copy-Item` can silently miss files if commands aren't verified against `Get-ChildItem` afterward.

\- \*\*`terraform plan -target` accumulates warnings, not certainty\*\*: repeated targeted applies during troubleshooting are useful for isolating one module, but always follow up with a full untargeted `terraform plan` to confirm nothing else drifted before considering a fix complete.



\## Cost awareness



The NAT Gateway and ALB are the dominant recurring costs per environment. Elastic IPs also bill hourly even when unattached — always check `aws ec2 describe-addresses` after a `destroy` to confirm none were orphaned. S3, ECR, IAM, CloudWatch log groups, and DynamoDB (on-demand) are negligible in comparison.



