output "plan_id" {
  description = "App Service Plan resource ID."
  value       = azurerm_service_plan.plan.id
}

output "site_id" {
  description = "Web App resource ID. Empty when not created."
  value       = try(azurerm_windows_web_app.site[0].id, "")
}
