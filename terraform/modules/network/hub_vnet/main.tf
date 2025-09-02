/**
 * Module: network/hub_vnet
 * Purpose: Create a Hub VNet with common subnets and optional DDOS plan.
 * Scope: Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_virtual_network" "hub" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  address_space = var.address_space

  # Enable DDOS plan when ID provided
  ddos_protection_plan {
    enable = var.ddos_plan_id != ""
    id     = var.ddos_plan_id != "" ? var.ddos_plan_id : null
  }

  tags = var.tags
}

# Subnets
resource "azurerm_subnet" "subnets" {
  for_each             = { for s in var.subnets : s.name => s }
  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub.name

  # Use address_prefixes for current provider versions
  address_prefixes = each.value.address_prefixes

  # These toggles control Private Link policies at the subnet level
  private_link_service_network_policies_enabled = lookup(each.value, "private_link_service_network_policies_enabled", true)

  # Optional service endpoints
  service_endpoints = lookup(each.value, "service_endpoints", [])

  # Optional delegation block if provided
  dynamic "delegation" {
    for_each = lookup(each.value, "delegations", [])
    content {
      name = delegation.value.name
      service_delegation {
        name = delegation.value.service
        actions = try(delegation.value.actions, [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ])
      }
    }
  }
}
