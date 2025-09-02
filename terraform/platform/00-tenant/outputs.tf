output "management_group_ids" {
  description = "Map of logical name -> MG resource ID."
  value       = { for k, m in module.mg : k => m.management_group_id }
}

output "management_group_names" {
  description = "Map of logical name -> MG name."
  value       = { for k, m in module.mg : k => m.management_group_name }
}
