/**
 * Module: core/role_assignments
 * Purpose: Create RBAC role assignments at one scope per invocation.
 * Supported scopes: Management Group, Subscription, Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

locals {
  mg_scope  = "/providers/Microsoft.Management/managementGroups/${var.management_group_id}"
  sub_scope = "/subscriptions/${var.subscription_id}"
  rg_scope  = var.resource_group_name != "" ? "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}" : null

  scope = var.scope_type == "management_group" ? local.mg_scope : var.scope_type == "subscription" ? local.sub_scope : var.scope_type == "resource_group" ? local.rg_scope : null
}

# Validate scope selection early
resource "null_resource" "validate_scope" {
  triggers = {
    selected_scope = local.scope != null ? local.scope : "INVALID"
  }
  lifecycle {
    precondition {
      condition     = local.scope != null
      error_message = "Invalid scope. Check scope_type and corresponding IDs."
    }
  }
}

# Owners
resource "azurerm_role_assignment" "owners" {
  for_each             = toset(var.owners)
  scope                = local.scope
  principal_id         = each.value
  principal_type       = var.owners_principal_type
  role_definition_name = "Owner"
}

# Contributors
resource "azurerm_role_assignment" "contributors" {
  for_each             = toset(var.contributors)
  scope                = local.scope
  principal_id         = each.value
  principal_type       = var.contributors_principal_type
  role_definition_name = "Contributor"
}

# Additional role assignments
resource "azurerm_role_assignment" "additional" {
  for_each       = { for a in var.additional : "${a.principal_id}-${a.role_definition_id}" => a }
  scope          = local.scope
  principal_id   = each.value.principal_id
  principal_type = lookup(each.value, "principal_type", "Group")

  # Require explicit role_definition_id for deterministic behavior across scopes
  role_definition_id = "/providers/Microsoft.Authorization/roleDefinitions/${each.value.role_definition_id}"
}
