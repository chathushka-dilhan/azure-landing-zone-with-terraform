output "script_id" {
  description = "Deployment Script resource ID. Empty when disabled."
  value       = try(azapi_resource.deployment_script[0].id, "")
}
