// main.tf
# Written by Marc Straubinger - Overhauled for Security-First Best Practices

# Current AWS Account ID
data "aws_caller_identity" "current" {}

# Default KMS Policy Document
data "aws_iam_policy_document" "default" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  # Example of restricting usage to specific services could be added here or via variable
}

# KMS Key
# PSA Compliance: Req 1 (encryption key management)
resource "aws_kms_key" "this" {
  description              = var.description != "" ? var.description : "KMS Key for ${var.project_name} ${var.environment}"
  key_usage                = var.key_usage
  customer_master_key_spec = var.customer_master_key_spec
  policy                   = var.policy != "" ? var.policy : data.aws_iam_policy_document.default.json
  deletion_window_in_days  = var.deletion_window_in_days
  is_enabled               = var.is_enabled
  enable_key_rotation      = var.enable_key_rotation
  multi_region             = var.multi_region

  tags = merge(local.common_tags, {
    "Name"          = local.alias_name
    "PSA-Compliant" = "true"
  })

  lifecycle {
    precondition {
      condition = (
        var.key_usage == "ENCRYPT_DECRYPT" ? contains(["SYMMETRIC_DEFAULT", "RSA_2048", "RSA_3072", "RSA_4096"], var.customer_master_key_spec) :
        var.key_usage == "SIGN_VERIFY" ? contains(["RSA_2048", "RSA_3072", "RSA_4096", "ECC_NIST_P256", "ECC_NIST_P384", "ECC_NIST_P521", "ECC_SECG_P256K1"], var.customer_master_key_spec) :
        true
      )
      error_message = "customer_master_key_spec is not compatible with the selected key_usage."
    }
  }
}

# KMS Alias
resource "aws_kms_alias" "this" {
  name          = "alias/${var.alias_name != "" ? var.alias_name : "${local.name_prefix}-kms"}"
  target_key_id = aws_kms_key.this.key_id
}

# KMS Grant
resource "aws_kms_grant" "this" {
  for_each = var.grants

  key_id            = aws_kms_key.this.key_id
  grantee_principal = each.value.grantee_principal
  operations        = each.value.operations
  name              = each.value.name

  dynamic "constraints" {
    for_each = each.value.constraints != null ? [each.value.constraints] : []
    content {
      encryption_context_equals = constraints.value.encryption_context_equals
      encryption_context_subset = constraints.value.encryption_context_subset
    }
  }
}
