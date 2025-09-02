/**
 * Module: identity/managed_identities
 * Purpose: Create one or more User Assigned Managed Identities.
 * Scope: Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_user_assigned_identity" "uami" {
  for_each            = { for i in var.identities : i.name => i }
  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = lookup(each.value, "tags", var.tags)
}
