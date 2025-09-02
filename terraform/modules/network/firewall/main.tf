/**
 * Module: network/firewall
 * Purpose: Deploy Azure Firewall in a Hub VNet with a public IP and optional Firewall Policy.
 * Scope: Resource Group
 * Note: Ensure AzureFirewallSubnet exists in the VNet.
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_public_ip" "fw_pip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.tags
}

resource "azurerm_firewall" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_name = "AZFW_VNet"
  sku_tier = var.tier

  ip_configuration {
    name                 = "configuration"
    subnet_id            = "${var.vnet_id}/subnets/AzureFirewallSubnet"
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }

  firewall_policy_id = var.firewall_policy_id != "" ? var.firewall_policy_id : null
  tags               = var.tags
}
