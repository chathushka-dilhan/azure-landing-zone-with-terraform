variable "scope_type" {
  description = "Target scope type."
  type        = string
  validation {
    condition     = contains(["management_group", "subscription", "resource_group"], var.scope_type)
    error_message = "scope_type must be one of management_group, subscription, resource_group."
  }
}

variable "management_group_id" {
  description = "Management Group ID when scope_type is management_group."
  type        = string
  default     = ""
}

variable "subscription_id" {
  description = "Subscription ID when scope_type is subscription or resource_group."
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Resource Group name when scope_type is resource_group."
  type        = string
  default     = ""
}

variable "owners" {
  description = "Owner principal object IDs."
  type        = list(string)
  default     = []
}

variable "contributors" {
  description = "Contributor principal object IDs."
  type        = list(string)
  default     = []
}

variable "owners_principal_type" {
  description = "Principal type for owners. User, Group, or ServicePrincipal."
  type        = string
  default     = "Group"
}

variable "contributors_principal_type" {
  description = "Principal type for contributors. User, Group, or ServicePrincipal."
  type        = string
  default     = "Group"
}

variable "additional" {
  description = <<EOT
Additional assignments. Example:
[
  { principal_id = "00000000-0000-0000-0000-000000000001", role_definition_id = "acdd72a7-3385-48ef-bd42-f606fba81ae7", principal_type = "Group" }
]
EOT
  type = list(object({
    principal_id       = string
    role_definition_id = string # GUID of the role definition
    principal_type     = optional(string, "Group")
  }))
  default = []
}
