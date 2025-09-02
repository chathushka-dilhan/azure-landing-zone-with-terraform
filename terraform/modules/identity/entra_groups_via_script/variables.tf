variable "enabled" {
  description = "Set true to run the deployment script. Keep false by default."
  type        = bool
  default     = false
}

variable "subscription_id" {
  description = "Subscription ID for the resource group that hosts the deployment script."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group that hosts the deployment script."
  type        = string
}

variable "location" {
  description = "Region where the deployment script runs."
  type        = string
}

variable "user_assigned_identity_id" {
  description = "Resource ID of a User Assigned Managed Identity with Graph permissions to manage groups."
  type        = string
}

variable "groups" {
  description = <<EOT
Groups to create. Example:
[
  { displayName = "ENTRA-GRP-APP-OWNERS", description = "Application owners", mailNickname = "appowners" },
  { displayName = "ENTRA-GRP-APP-OPS",    description = "Application operators" }
]
EOT
  type = list(object({
    displayName = string
    description = optional(string, "")
    mailNickname = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags applied to the deployment script resource."
  type        = map(string)
  default     = {}
}
