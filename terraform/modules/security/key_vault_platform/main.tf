/**
 * Module: security/key_vault_platform
 * Purpose: Platform Key Vault with RBAC authorization and purge protection.
 * Scope: Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_key_vault" "kv" {
  name                       = var.name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  tenant_id                  = var.tenant_id
  sku_name                   = "standard"

  # Use RBAC, not access policies
  enable_rbac_authorization = true

  # Strong delete safeguards
  purge_protection_enabled   = true
  soft_delete_retention_days = var.soft_delete_retention_days

  public_network_access_enabled = var.public_network_access_enabled

  network_acls {
    default_action = var.firewall_default_action
    bypass         = var.firewall_bypass
    ip_rules       = var.firewall_ip_rules
    virtual_network_subnet_ids = var.firewall_vnet_subnet_ids
  }

  tags = var.tags
}
