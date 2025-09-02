output "association_id" {
  description = "Association identifier."
  value       = azurerm_management_group_subscription_association.assoc.id
}

output "subscription_tags_applied" {
  description = "True when tags were applied."
  value       = length(var.tags) > 0
}
