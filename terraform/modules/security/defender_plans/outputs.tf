output "plans_configured" {
  description = "Defender plan resource types configured."
  value       = keys(azurerm_security_center_subscription_pricing.plan)
}

output "auto_provisioning" {
  description = "Auto provisioning setting."
  value       = azurerm_security_center_auto_provisioning.auto.auto_provision
}
