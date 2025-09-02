variable "name" {
  description = "Key Vault name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Region."
  type        = string
}

variable "tenant_id" {
  description = "AAD tenant ID."
  type        = string
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention in days."
  type        = number
  default     = 90
}

variable "public_network_access_enabled" {
  description = "Enable public network access."
  type        = bool
  default     = true
}

variable "firewall_default_action" {
  description = "Key Vault firewall default action. Allow or Deny."
  type        = string
  default     = "Allow"
  validation {
    condition     = contains(["Allow", "Deny"], var.firewall_default_action)
    error_message = "firewall_default_action must be Allow or Deny."
  }
}

variable "firewall_bypass" {
  description = "Firewall bypass setting. AzureServices or None."
  type        = string
  default     = "AzureServices"
  validation {
    condition     = contains(["AzureServices", "None"], var.firewall_bypass)
    error_message = "firewall_bypass must be AzureServices or None."
  }
}

variable "firewall_ip_rules" {
  description = "List of CIDR IP ranges allowed to access the vault."
  type        = list(string)
  default     = []
}

variable "firewall_vnet_subnet_ids" {
  description = "List of subnet resource IDs that can access the vault."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
