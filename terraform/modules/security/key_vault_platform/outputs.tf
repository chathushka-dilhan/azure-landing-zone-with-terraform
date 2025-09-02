output "key_vault_id" {
  description = "Key Vault resource ID."
  value       = azurerm_key_vault.kv.id
}

output "key_vault_uri" {
  description = "Vault URI."
  value       = azurerm_key_vault.kv.vault_uri
}
