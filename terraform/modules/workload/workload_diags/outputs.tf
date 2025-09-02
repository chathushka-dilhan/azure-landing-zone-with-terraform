output "diagnostic_setting_ids" {
  description = "Diagnostic setting IDs per target."
  value       = [for d in azurerm_monitor_diagnostic_setting.diag : d.id]
}
