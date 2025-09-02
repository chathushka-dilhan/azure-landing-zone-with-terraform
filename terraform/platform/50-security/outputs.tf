output "sentinel_workspace_id" {
  description = "Workspace ID used by Sentinel."
  value       = module.sentinel.workspace_id
}

output "defender_plans_configured" {
  description = "Resource types with Defender plan enabled."
  value       = module.defender.plans_configured
}

output "platform_key_vault_id" {
  description = "Key Vault resource ID."
  value       = module.kv_platform.key_vault_id
}

output "platform_key_vault_uri" {
  description = "Key Vault URI."
  value       = module.kv_platform.key_vault_uri
}
