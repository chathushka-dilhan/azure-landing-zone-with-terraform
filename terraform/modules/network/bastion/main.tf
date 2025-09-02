/**
 * Module: network/bastion
 * Purpose: Deploy Azure Bastion with a Standard Public IP into AzureBastionSubnet.
 * Scope: Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.tags
}

resource "azurerm_bastion_host" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                 = "bastion"
    subnet_id            = "${var.vnet_id}/subnets/AzureBastionSubnet"
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }

  sku          = var.sku
  copy_paste_enabled = true
  file_copy_enabled  = true
  scale_units        = var.scale_units

  tags = var.tags
}
