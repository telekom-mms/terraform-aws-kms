// outputs.tf

output "key_arn" {
  description = "The ARN of the KMS key"
  value       = aws_kms_key.this.arn
}

output "key_id" {
  description = "The ID of the KMS key"
  value       = aws_kms_key.this.key_id
}

output "alias_arn" {
  description = "The ARN of the KMS key alias"
  value       = aws_kms_alias.this.arn
}

output "alias_name" {
  description = "The name of the KMS key alias"
  value       = aws_kms_alias.this.name
}

output "grant_ids" {
  description = "Map of KMS grant IDs keyed by grant name"
  value       = { for name, grant in aws_kms_grant.this : name => grant.grant_id }
}

output "grant_tokens" {
  description = "Map of KMS grant tokens keyed by grant name"
  value       = { for name, grant in aws_kms_grant.this : name => grant.grant_token }
}
