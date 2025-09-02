/**
 * Module: workload/route_tables_nsgs
 * Purpose: Create multiple route tables and NSGs with rules.
 * Scope: Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_route_table" "rt" {
  for_each            = { for r in var.route_tables : r.name => r }
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  bgp_route_propagation_enabled = lookup(each.value, "bgp_route_propagation_enabled", false)
  tags                = var.tags

  dynamic "route" {
    for_each = lookup(each.value, "routes", [])
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = try(route.value.next_hop_ip_address, null)
    }
  }
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = { for n in var.nsgs : n.name => n }
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  dynamic "security_rule" {
    for_each = lookup(each.value, "rules", [])
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_ports
      destination_port_range     = security_rule.value.destination_ports
      source_address_prefix      = security_rule.value.source
      destination_address_prefix = security_rule.value.destination
    }
  }
}
