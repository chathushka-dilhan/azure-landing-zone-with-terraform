variable "create_subscription" {
  description = "If true, create a new subscription using Microsoft.Subscription/aliases. If false, onboard an existing subscription_id."
  type        = bool
  default     = false
}

variable "subscription_id" {
  description = "Existing subscription GUID to onboard when create_subscription is false."
  type        = string
  default     = ""
}

variable "management_group_id" {
  description = "Target Management Group ID, for example contoso-lz-corp."
  type        = string
}

variable "tags" {
  description = "Tags applied at subscription scope."
  type        = map(string)
  default     = {}
}

# Creation-specific inputs
variable "alias_name" {
  description = "Alias name for the new subscription when create_subscription is true."
  type        = string
  default     = "lz-subscription"
}

variable "billing_scope_id" {
  description = "Billing scope resource ID for subscription creation. Example (EA/MCA): /providers/Microsoft.Billing/billingAccounts/xxxx:yyyy/billingProfiles/zzzz/invoiceSections/aaaa"
  type        = string
  default     = ""
}

variable "display_name" {
  description = "Subscription display name when creating a new subscription."
  type        = string
  default     = "Landing Zone"
}

variable "workload" {
  description = "Subscription workload intent. Production or DevTest."
  type        = string
  default     = "Production"
  validation {
    condition     = contains(["Production", "DevTest"], var.workload)
    error_message = "workload must be Production or DevTest."
  }
}

# Optional RBAC vending
variable "rbac_owners" {
  description = "Owner principal object IDs to assign at the subscription."
  type        = list(string)
  default     = []
}

variable "rbac_contributors" {
  description = "Contributor principal object IDs to assign at the subscription."
  type        = list(string)
  default     = []
}
