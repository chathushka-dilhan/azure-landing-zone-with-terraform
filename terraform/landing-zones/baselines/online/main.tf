/**
 * Baseline: online
 * Purpose: Per-subscription baseline for internet-facing landing zones.
 * Similar to corp, but leaves network controls to app teams and platform guardrails.
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_resource_group" "baseline" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Minimal, optional NSGs for perimeter subnets
module "security_min" {
  count               = length(var.nsgs) > 0 ? 1 : 0
  source              = "../../../modules/workload/route_tables_nsgs"
  resource_group_name = azurerm_resource_group.baseline.name
  location            = azurerm_resource_group.baseline.location
  route_tables        = []       # Usually no UDRs in online unless required
  nsgs                = var.nsgs
  tags                = var.tags
}

module "rbac" {
  count               = (length(var.rbac_owners) + length(var.rbac_contributors)) > 0 ? 1 : 0
  source              = "../../../modules/core/role_assignments"
  scope_type          = "subscription"
  subscription_id     = var.subscription_id
  owners              = var.rbac_owners
  contributors        = var.rbac_contributors
}

module "diags" {
  count        = length(var.diagnostic_targets) > 0 && var.workspace_id != "" ? 1 : 0
  source       = "../../../modules/workload/workload_diags"
  workspace_id = var.workspace_id
  resource_ids = var.diagnostic_targets
}
