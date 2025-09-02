variable "resource_group_name" {
  description = "RG hosting identity artifacts."
  type        = string
}

variable "location" {
  description = "Region."
  type        = string
}

variable "managed_identities" {
  description = <<EOT
List of user-assigned managed identities to create.
[
  { name = "mi-platform-deployer", tags = { managedBy = "iac" } },
  { name = "mi-policy-runner" }
]
EOT
  type = list(object({
    name = string
    tags = optional(map(string))
  }))
  default = []
}

variable "rbac_scope_type" {
  description = "Optional, create role assignments for the identities. management_group | subscription | resource_group | none"
  type        = string
  default     = "none"
}

variable "rbac_management_group_id" {
  type    = string
  default = ""
}

variable "rbac_subscription_id" {
  type    = string
  default = ""
}

variable "rbac_resource_group_name" {
  type    = string
  default = ""
}

variable "rbac_owners" {
  description = "Optional owners to assign at scope."
  type        = list(string)
  default     = []
}

variable "rbac_contributors" {
  description = "Optional contributors to assign at scope."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Default tags."
  type        = map(string)
  default     = {}
}
