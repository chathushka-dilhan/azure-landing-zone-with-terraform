output "definition_ids" {
  description = "Custom policy definition IDs."
  value = {
    allowed_locations = azurerm_policy_definition.allowed_locations.id
    deny_public_ip    = azurerm_policy_definition.deny_public_ip.id
  }
}

output "platform_baseline_id" {
  description = "Policy set (initiative) ID."
  value       = azurerm_policy_set_definition.platform_baseline.id
}
