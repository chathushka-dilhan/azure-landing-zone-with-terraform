output "management_group_id" {
  description = "Resource ID of the management group."
  value       = azurerm_management_group[this].id
}

output "management_group_name" {
  description = "Name of the management group."
  value       = azurerm_management_group[this].name
}
