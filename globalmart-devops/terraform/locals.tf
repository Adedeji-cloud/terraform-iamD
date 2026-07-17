locals {

  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = {

    Project     = var.project_name

    Environment = title(var.environment)

    ManagedBy   = "Terraform"

    Application = "glob.mart E-Commerce"

    Owner       = "Adedeji"

  }

}