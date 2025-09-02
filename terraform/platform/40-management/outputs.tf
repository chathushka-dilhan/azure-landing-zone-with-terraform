output "log_analytics_workspace_id" {
  description = "LAW resource ID."
  value       = module.law.workspace_id
}

output "action_group_id" {
  description = "Action Group ID."
  value       = module.ag.action_group_id
}

output "dcr_id" {
  description = "Data Collection Rule ID."
  value       = module.dcr.dcr_id
}

output "recovery_services_vault_id" {
  description = "RSV ID."
  value       = module.backup.vault_id
}
