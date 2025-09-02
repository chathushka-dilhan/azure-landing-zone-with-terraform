/**
 * Baseline: corp
 * Purpose: Per-subscription baseline for corporate landing zones.
 * - Create a baseline resource group
 * - Optional basic hub-spoke client assets (RTs, NSGs)
 * - Assign RBAC at subscription scope for app teams
 * - Apply diagnostics on selected resource IDs
 * Note: Network and shared services live in platform stacks. Keep LZ slim.
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_resource_group" "baseline" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Optional routing and NSGs for common subnets in the LZ
module "routing_security" {
  count               = length(var.route_tables) + length(var.nsgs) > 0 ? 1 : 0
  source              = "../../../modules/workload/route_tables_nsgs"
  resource_group_name = azurerm_resource_group.baseline.name
  location            = azurerm_resource_group.baseline.location
  route_tables        = var.route_tables
  nsgs                = var.nsgs
  tags                = var.tags
}

# RBAC for app teams at subscription scope
module "rbac" {
  count               = (length(var.rbac_owners) + length(var.rbac_contributors)) > 0 ? 1 : 0
  source              = "../../../modules/core/role_assignments"
  scope_type          = "subscription"
  subscription_id     = var.subscription_id
  owners              = var.rbac_owners
  contributors        = var.rbac_contributors
}

# Diagnostics for select resource IDs in this subscription
module "diags" {
  count        = length(var.diagnostic_targets) > 0 && var.workspace_id != "" ? 1 : 0
  source       = "../../../modules/workload/workload_diags"
  workspace_id = var.workspace_id
  resource_ids = var.diagnostic_targets
}
