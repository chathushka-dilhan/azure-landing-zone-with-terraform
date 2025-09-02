output "route_table_ids" {
  description = "Map of route table name to resource ID."
  value       = { for k, v in azurerm_route_table.rt : k => v.id }
}

output "nsg_ids" {
  description = "Map of NSG name to resource ID."
  value       = { for k, v in azurerm_network_security_group.nsg : k => v.id }
}
