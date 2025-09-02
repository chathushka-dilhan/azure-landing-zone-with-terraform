variable "create_workspace" {
  description = "If true, create a Log Analytics workspace. If false, use workspace_id."
  type        = bool
  default     = false
}

variable "workspace_id" {
  description = "Existing Log Analytics workspace resource ID when create_workspace is false."
  type        = string
  default     = ""
}

variable "workspace_name" {
  description = "Log Analytics workspace name when creating one."
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "Resource Group for the workspace when creating one."
  type        = string
  default     = ""
}

variable "location" {
  description = "Region for the workspace when creating one."
  type        = string
  default     = ""
}

variable "workspace_sku" {
  description = "Log Analytics SKU."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Retention in days for Log Analytics."
  type        = number
  default     = 30
}

variable "daily_quota_gb" {
  description = "Daily ingestion cap in GB. 0 means unlimited."
  type        = number
  default     = 0
}

variable "tags" {
  description = "Resource tags for the workspace."
  type        = map(string)
  default     = {}
}
