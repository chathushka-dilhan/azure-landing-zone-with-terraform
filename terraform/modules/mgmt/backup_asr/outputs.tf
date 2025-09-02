output "vault_id" {
  description = "Recovery Services Vault resource ID."
  value       = azurerm_recovery_services_vault.rsv.id
}

output "backup_policy_id" {
  description = "Default VM backup policy resource ID."
  value       = azurerm_backup_policy_vm.vm.id
}
