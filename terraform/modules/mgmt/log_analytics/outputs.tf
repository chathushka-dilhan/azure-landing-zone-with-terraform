output "workspace_id" {
  description = "Log Analytics workspace resource ID."
  value       = azurerm_log_analytics_workspace.law.id
}

output "workspace_name" {
  description = "Workspace name."
  value       = azurerm_log_analytics_workspace.law.name
}

output "workspace_customer_id" {
  description = "Workspace customer ID (GUID)."
  value       = azurerm_log_analytics_workspace.law.workspace_id
}
