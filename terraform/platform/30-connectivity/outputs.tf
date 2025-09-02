output "vwan_id" {
  description = "Virtual WAN ID when deployed."
  value       = try(module.vwan[0].id, "")
}

output "hub_vnet_id" {
  description = "Hub VNet ID when deployed."
  value       = try(module.hub_vnet[0].vnet_id, "")
}

output "hub_subnet_ids" {
  description = "Map of hub subnet name to ID."
  value       = try(module.hub_vnet[0].subnet_ids, {})
}

output "firewall_public_ip" {
  description = "Firewall public IP address."
  value       = try(module.firewall[0].public_ip, "")
}
