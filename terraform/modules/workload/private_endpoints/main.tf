/**
 * Module: workload/private_endpoints
 * Purpose: Create multiple Private Endpoints and optional DNS zone groups.
 * Scope: Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

# One NIC per private endpoint, each connecting to the specified subnet
resource "azurerm_private_endpoint" "pe" {
  for_each            = { for e in var.endpoints : e.name => e }
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.subnet_id
  tags                = lookup(each.value, "tags", var.tags)

  private_service_connection {
    name                           = "${each.value.name}-pls"
    private_connection_resource_id = each.value.target_resource_id
    is_manual_connection           = false
    subresource_names              = each.value.group_ids
  }
}

# Optional DNS zone group attachment per endpoint
resource "azurerm_private_dns_zone_group" "zone_group" {
  for_each             = { for e in var.endpoints : e.name => e if try(length(e.dns_zone_ids) > 0, false) }
  name                 = "default"
  private_endpoint_id  = azurerm_private_endpoint.pe[each.key].id

  dynamic "private_dns_zone_configs" {
    for_each = each.value.dns_zone_ids
    content {
      name                 = regex("[^/]+$", private_dns_zone_configs.value)
      private_dns_zone_id  = private_dns_zone_configs.value
    }
  }
}
