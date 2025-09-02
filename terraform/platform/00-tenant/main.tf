/**
 * Root: 00-tenant
 * Purpose: Create the management group hierarchy.
 * Scope: Tenant
 */

terraform {
  required_version = ">= 1.5.0"
}

# Create MGs in dependency order based on parent references
locals {
  mg_list = [
    for k, v in var.management_groups : {
      key          = k
      id           = v.id
      display_name = v.display_name
      parent       = v.parent
      tags         = merge(var.tags, v.tags)
    }
  ]
}

module "mg" {
  for_each = {
    for m in local.mg_list : m.key => m
  }
  source                   = "../../modules/core/management_group"
  management_group_id      = each.value.id
  display_name             = each.value.display_name
  parent_management_group_id = each.value.parent
}
