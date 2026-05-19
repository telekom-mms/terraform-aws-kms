// variables.tf

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment (e.g., prod, dev, test)"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names (if not provided, will use project-environment pattern)"
  type        = string
  default     = ""
}


variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}

variable "alias_name" {
  description = "Name of the KMS key alias (if empty, will use project-environment pattern)"
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of the KMS key"
  type        = string
  default     = ""
}

variable "key_usage" {
  description = "Specifies the intended use of the key"
  type        = string
  default     = "ENCRYPT_DECRYPT"
  validation {
    condition     = contains(["ENCRYPT_DECRYPT", "SIGN_VERIFY"], var.key_usage)
    error_message = "Key usage must be either ENCRYPT_DECRYPT or SIGN_VERIFY."
  }
}

variable "customer_master_key_spec" {
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair"
  type        = string
  default     = "SYMMETRIC_DEFAULT"
}

variable "policy" {
  description = "A valid policy JSON document. If not provided, a default secure policy will be created."
  type        = string
  default     = ""
}

variable "deletion_window_in_days" {
  description = "Duration in days after which the key is deleted after destruction"
  type        = number
  default     = 30 # Security first: longer window to prevent accidental deletion
}

variable "is_enabled" {
  description = "Specifies whether the key is enabled"
  type        = bool
  default     = true
}

variable "enable_key_rotation" {
  description = "Specifies whether key rotation is enabled"
  type        = bool
  default     = true # PSA Req 3.50-05: Rotation is mandatory
}

variable "multi_region" {
  description = "Indicates whether the KMS key is a multi-Region key"
  type        = bool
  default     = false
}

variable "grants" {
  description = "A map of grants to create"
  type = map(object({
    name              = string
    grantee_principal = string
    operations        = list(string)
    constraints = optional(object({
      encryption_context_equals = optional(map(string))
      encryption_context_subset = optional(map(string))
    }))
  }))
  default = {}
}
