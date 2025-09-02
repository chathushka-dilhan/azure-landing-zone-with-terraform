output "workspace_id" {
  description = "Log Analytics workspace resource ID."
  value       = var.create_workspace ? azurerm_log_analytics_workspace.law[0].id : var.workspace_id
}

output "sentinel_onboarding_id" {
  description = "Sentinel onboarding resource ID."
  value       = azurerm_sentinel_log_analytics_workspace_onboarding.onboarding.id
}
