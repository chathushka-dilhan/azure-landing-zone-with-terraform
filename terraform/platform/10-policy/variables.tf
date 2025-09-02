variable "management_group_ids" {
  description = "Target MG IDs for assignments. Provide IDs from 00-tenant outputs."
  type = object({
    platform     = string
    security     = string
    management   = string
    connectivity = string
    identity     = string
    landingzones = string
    corp         = string
    online       = string
  })
}

variable "policy_tags" {
  description = "Tags applied to definition resources where supported."
  type        = map(string)
  default     = {}
}

# Optional assignment parameters
variable "allowed_locations" {
  description = "List of allowed locations for the Allowed Locations policy."
  type        = list(string)
  default     = ["southeastasia", "eastasia"]
}

variable "deny_public_ip_effect" {
  description = "Effect for deny public IP on NICs and VM IPs. Deny or Audit."
  type        = string
  default     = "Deny"
}

variable "log_analytics_workspace_id" {
  description = "Workspace for diagnostics initiative, used in assignment parameters."
  type        = string
  default     = ""
}
