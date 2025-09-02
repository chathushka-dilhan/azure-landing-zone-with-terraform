/**
 * Module: network/private_dns_resolver
 * Purpose: Deploy Private DNS Resolver with inbound and outbound endpoints.
 * Scope: Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_private_dns_resolver" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  virtual_network_id  = var.vnet_id
  tags                = var.tags
}

resource "azurerm_private_dns_resolver_inbound_endpoint" "inbound" {
  name                    = "${var.name}-inbound"
  location                = var.location
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id

  ip_configurations {
    subnet_id = var.inbound_subnet_id != "" ? var.inbound_subnet_id : "${var.vnet_id}/subnets/${var.inbound_subnet_name}"
  }

  tags = var.tags
}

resource "azurerm_private_dns_resolver_outbound_endpoint" "outbound" {
  name                    = "${var.name}-outbound"
  location                = var.location
  private_dns_resolver_id = azurerm_private_dns_resolver.this.id
  subnet_id               = var.outbound_subnet_id != "" ? var.outbound_subnet_id : "${var.vnet_id}/subnets/${var.outbound_subnet_name}"
  tags                    = var.tags
}
