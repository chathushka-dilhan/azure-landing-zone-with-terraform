/**
 * Root: 20-identity
 * Purpose: Create platform User Assigned Managed Identities and optionally assign RBAC.
 */

terraform {
  required_version = ">= 1.5.0"
}

module "uami" {
  source              = "../../modules/identity/managed_identities"
  resource_group_name = var.resource_group_name
  location            = var.location
  identities          = var.managed_identities
  tags                = var.tags
}

module "rbac" {
  count                 = var.rbac_scope_type == "none" ? 0 : 1
  source                = "../../modules/core/role_assignments"
  scope_type            = var.rbac_scope_type
  management_group_id   = var.rbac_management_group_id
  subscription_id       = var.rbac_subscription_id
  resource_group_name   = var.rbac_resource_group_name
  owners                = var.rbac_owners
  contributors          = var.rbac_contributors
}
