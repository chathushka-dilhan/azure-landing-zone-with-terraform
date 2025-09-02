output "subscription_id" {
  description = "Resulting subscription GUID."
  value       = local.effective_subscription
}

output "onboard_association_id" {
  description = "Association id for MG to subscription link."
  value       = module.onboard.association_id
}
