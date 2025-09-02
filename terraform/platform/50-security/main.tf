/**
 * Root: 50-security
 * Purpose: Onboard Sentinel, enable Defender plans, and deploy platform Key Vault.
 */

terraform {
  required_version = ">= 1.5.0"
}

module "sentinel" {
  source              = "../../modules/security/sentinel"
  create_workspace    = var.sentinel.create_workspace
  workspace_id        = try(var.sentinel.workspace_id, "")
  workspace_name      = try(var.sentinel.workspace_name, "")
  resource_group_name = var.resource_group_name
  location            = var.location
  workspace_sku       = try(var.sentinel.workspace_sku, "PerGB2018")
  retention_in_days   = try(var.sentinel.retention_in_days, 30)
  daily_quota_gb      = try(var.sentinel.daily_quota_gb, 0)
  tags                = try(var.sentinel.tags, {})
}

module "defender" {
  source                      = "../../modules/security/defender_plans"
  auto_provisioning_on        = try(var.defender.auto_provisioning_on, true)
  contact_email               = try(var.defender.contact_email, "")
  contact_phone               = try(var.defender.contact_phone, "")
  alert_notifications         = try(var.defender.alert_notifications, true)
  alerts_to_subscription_owners = try(var.defender.alerts_to_subscription_owners, false)
  plans                       = var.defender.plans
}

module "kv_platform" {
  source                        = "../../modules/security/key_vault_platform"
  name                          = var.platform_key_vault.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tenant_id                     = var.platform_key_vault.tenant_id
  public_network_access_enabled = try(var.platform_key_vault.public_network_access_enabled, true)
  firewall_default_action       = try(var.platform_key_vault.firewall_default_action, "Allow")
  firewall_bypass               = try(var.platform_key_vault.firewall_bypass, "AzureServices")
  firewall_ip_rules             = try(var.platform_key_vault.firewall_ip_rules, [])
  firewall_vnet_subnet_ids      = try(var.platform_key_vault.firewall_vnet_subnet_ids, [])
  soft_delete_retention_days    = try(var.platform_key_vault.soft_delete_retention_days, 90)
  tags                          = try(var.platform_key_vault.tags, {})
}
