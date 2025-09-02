output "scope" {
  description = "The scope where RBAC was applied."
  value       = local.scope
}

output "owner_assignment_ids" {
  description = "Owner assignment resource IDs."
  value       = [for r in azurerm_role_assignment.owners : r.id]
}

output "contributor_assignment_ids" {
  description = "Contributor assignment resource IDs."
  value       = [for r in azurerm_role_assignment.contributors : r.id]
}

output "additional_assignment_ids" {
  description = "Additional assignment resource IDs."
  value       = [for r in azurerm_role_assignment.additional : r.id]
}
