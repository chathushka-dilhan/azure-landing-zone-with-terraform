variable "resource_group_name" {
  description = "Security RG."
  type        = string
}

variable "location" {
  description = "Region."
  type        = string
}

variable "sentinel" {
  description = "Sentinel onboarding configuration."
  type = object({
    create_workspace   = bool
    workspace_id       = optional(string, "")
    workspace_name     = optional(string, "")
    workspace_sku      = optional(string, "PerGB2018")
    retention_in_days  = optional(number, 30)
    daily_quota_gb     = optional(number, 0)
    tags               = optional(map(string), {})
  })
}

variable "defender" {
  description = "Defender plans and contacts."
  type = object({
    auto_provisioning_on       = optional(bool, true)
    contact_email              = optional(string, "")
    contact_phone              = optional(string, "")
    alert_notifications        = optional(bool, true)
    alerts_to_subscription_owners = optional(bool, false)
    plans = map(string)  # e.g., { VirtualMachines = "Standard", StorageAccounts = "Standard" }
  })
}

variable "platform_key_vault" {
  description = "Platform Key Vault settings."
  type = object({
    name                          = string
    tenant_id                     = string
    public_network_access_enabled = optional(bool, true)
    firewall_default_action       = optional(string, "Allow")
    firewall_bypass               = optional(string, "AzureServices")
    firewall_ip_rules             = optional(list(string), [])
    firewall_vnet_subnet_ids      = optional(list(string), [])
    soft_delete_retention_days    = optional(number, 90)
    tags                          = optional(map(string), {})
  })
}
