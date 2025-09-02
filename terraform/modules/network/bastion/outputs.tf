output "bastion_id" {
  description = "Bastion resource ID."
  value       = azurerm_bastion_host.this.id
}

output "public_ip_id" {
  description = "Public IP resource ID."
  value       = azurerm_public_ip.bastion_pip.id
}

output "public_ip" {
  description = "Public IP address."
  value       = azurerm_public_ip.bastion_pip.ip_address
}
