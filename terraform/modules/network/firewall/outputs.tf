output "firewall_id" {
  description = "Azure Firewall resource ID."
  value       = azurerm_firewall.this.id
}

output "public_ip_id" {
  description = "Public IP resource ID."
  value       = azurerm_public_ip.fw_pip.id
}

output "public_ip" {
  description = "Public IP address once allocated."
  value       = azurerm_public_ip.fw_pip.ip_address
}
