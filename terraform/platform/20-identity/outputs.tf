output "managed_identity_ids" {
  description = "Map of MI name -> resource ID."
  value       = module.uami.identity_ids
}

output "managed_identity_principals" {
  description = "Map of MI name -> principal ID."
  value       = module.uami.principal_ids
}
