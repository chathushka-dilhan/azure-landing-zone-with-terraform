variable "name" {
  description = "Azure Firewall name."
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

variable "tier" {
  description = "Firewall SKU tier. Standard or Premium."
  type        = string
  default     = "Premium"
  validation {
    condition     = contains(["Standard", "Premium"], var.tier)
    error_message = "tier must be Standard or Premium."
  }
}

variable "vnet_id" {
  description = "Hub VNet resource ID that contains AzureFirewallSubnet."
  type        = string
}

variable "public_ip_name" {
  description = "Public IP resource name for the firewall."
  type        = string
}

variable "firewall_policy_id" {
  description = "Optional Firewall Policy resource ID."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
