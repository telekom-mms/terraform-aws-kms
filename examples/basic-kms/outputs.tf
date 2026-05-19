// examples/basic-kms/outputs.tf

output "key_id" {
  description = "ID of the KMS key"
  value       = module.kms.key_id
}

output "key_arn" {
  description = "ARN of the KMS key"
  value       = module.kms.key_arn
}

output "alias_name" {
  description = "Name of the KMS key alias"
  value       = module.kms.alias_name
}
