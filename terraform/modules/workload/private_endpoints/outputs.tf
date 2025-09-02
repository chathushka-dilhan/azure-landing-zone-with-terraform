output "private_endpoint_ids" {
  description = "Map of endpoint name to Private Endpoint resource ID."
  value       = { for k, v in azurerm_private_endpoint.pe : k => v.id }
}
