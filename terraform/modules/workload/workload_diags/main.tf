/**
 * Module: workload/workload_diags
 * Purpose: Apply diagnostic settings to a list of resource IDs.
 * Scope: Subscription or Resource Group for state, settings applied per-target.
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_monitor_diagnostic_setting" "diag" {
  for_each                       = toset(var.resource_ids)
  name                           = "diag-${substr(md5(each.value), 0, 10)}"
  target_resource_id             = each.value
  log_analytics_workspace_id     = var.workspace_id

  dynamic "enabled_log" {
    for_each = var.log_categories
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.metric_categories
    content {
      category = metric.value
      enabled  = true
    }
  }
}
