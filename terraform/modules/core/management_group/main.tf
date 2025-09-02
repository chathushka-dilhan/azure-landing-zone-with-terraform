/**
 * Module: core/management_group
 * Purpose: Create an Azure Management Group with optional parent and display name.
 * Scope: Tenant
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_management_group" "this" {
  # Unique ID for the management group, for example "contoso-platform"
  display_name                 = var.display_name != "" ? var.display_name : var.management_group_id
  name                         = var.management_group_id
  parent_management_group_id   = var.parent_management_group_id != "" ? "/providers/Microsoft.Management/managementGroups/${var.parent_management_group_id}" : null
}
