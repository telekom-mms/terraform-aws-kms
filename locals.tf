// locals.tf

locals {
  name_prefix = var.name_prefix != "" ? var.name_prefix : "${var.project_name}-${var.environment}"
  alias_name  = var.alias_name != "" ? var.alias_name : "${local.name_prefix}-kms"

  common_tags = merge(var.tags, {
    "Project"       = var.project_name
    "Environment"   = var.environment
    "ManagedBy"     = "Terraform"
    "PSA-Compliant" = "true"
  })
}
