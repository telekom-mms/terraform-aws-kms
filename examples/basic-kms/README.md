# AWS KMS Basic Example

This example demonstrates how to use the AWS KMS module to create a basic KMS key with key rotation and a grant.

## Features

- KMS Key with automatic rotation
- Grant for a Lambda role (replace with your actual Lambda role ARN)

## Usage

1.  Copy this example to your project.
2.  Update `variables.tf` with your specific values.
3.  **Important**: Before applying, ensure you replace `arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/example-lambda-role` in `main.tf` with the actual ARN of your Lambda role.
4.  Initialize and apply:
    ```bash
    terraform init
    terraform plan
    terraform apply
    ```

## Variables

See `variables.tf` for all configurable options.

## Outputs

- `key_id`: ID of the created KMS key.
- `key_arn`: ARN of the created KMS key.
- `alias_name`: Name of the KMS key alias.

## Requirements

- AWS CLI configured
- Terraform >= 1.0
