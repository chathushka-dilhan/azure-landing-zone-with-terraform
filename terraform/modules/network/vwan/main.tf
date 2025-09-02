/**
 * Module: network/vwan
 * Purpose: Create Azure Virtual WAN.
 * Scope: Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_virtual_wan" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  type                              = var.vwan_type
  allow_branch_to_branch_traffic    = var.allow_branch_to_branch
  office365_local_breakout_category = var.office365_breakout_category
  disable_vpn_encryption            = var.disable_vpn_encryption

  tags = var.tags
}
