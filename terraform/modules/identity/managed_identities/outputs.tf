output "identity_ids" {
  description = "Map of identity name to resource ID."
  value       = { for k, v in azurerm_user_assigned_identity.uami : k => v.id }
}

output "principal_ids" {
  description = "Map of identity name to principal ID (objectId)."
  value       = { for k, v in azurerm_user_assigned_identity.uami : k => v.principal_id }
}

output "client_ids" {
  description = "Map of identity name to client ID (appId)."
  value       = { for k, v in azurerm_user_assigned_identity.uami : k => v.client_id }
}
