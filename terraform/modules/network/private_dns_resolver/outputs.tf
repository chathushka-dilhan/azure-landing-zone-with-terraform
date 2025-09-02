output "resolver_id" {
  description = "Private DNS Resolver resource ID."
  value       = azurerm_private_dns_resolver.this.id
}

output "inbound_endpoint_id" {
  description = "Inbound endpoint resource ID."
  value       = azurerm_private_dns_resolver_inbound_endpoint.inbound.id
}

output "outbound_endpoint_id" {
  description = "Outbound endpoint resource ID."
  value       = azurerm_private_dns_resolver_outbound_endpoint.outbound.id
}
