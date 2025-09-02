/**
 * Module: security/sentinel
 * Purpose: Create or use a Log Analytics workspace, then enable Microsoft Sentinel.
 * Scope: Resource Group (workspace), Subscription-level service is bound to the workspace.
 */

terraform {
  required_version = ">= 1.5.0"
}

locals {
  use_existing = var.create_workspace == false
}

# Validate inputs
resource "null_resource" "validate" {
  lifecycle {
    precondition {
      condition     = var.create_workspace || (var.create_workspace == false && var.workspace_id != "")
      error_message = "workspace_id must be provided when create_workspace is false."
    }
    precondition {
      condition     = var.create_workspace ? (var.workspace_name != "" && var.resource_group_name != "" && var.location != "") : true
      error_message = "When create_workspace is true, workspace_name, resource_group_name, and location are required."
    }
  }
}

# Optional workspace creation
resource "azurerm_log_analytics_workspace" "law" {
  count               = var.create_workspace ? 1 : 0
  name                = var.workspace_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.workspace_sku
  retention_in_days   = var.retention_in_days
  daily_quota_gb      = var.daily_quota_gb
  tags                = var.tags
}

# Sentinel onboarding
resource "azurerm_sentinel_log_analytics_workspace_onboarding" "onboarding" {
  workspace_id = var.create_workspace ? azurerm_log_analytics_workspace.law[0].id : var.workspace_id
}
