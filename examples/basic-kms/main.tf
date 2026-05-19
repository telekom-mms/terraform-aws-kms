// examples/basic-kms/main.tf

provider "aws" {
  region = "eu-central-1"
}

module "kms" {
  source = "../../"

  project_name = var.project_name
  environment  = var.environment

  description         = "KMS key for example application"
  key_usage           = "ENCRYPT_DECRYPT"
  enable_key_rotation = true

  grants = {
    lambda_access = {
      name              = "lambda-access"
      grantee_principal = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/example-lambda-role"
      operations        = ["Decrypt", "GenerateDataKey"]
    }
  }

  tags = var.tags
}

data "aws_caller_identity" "current" {}
