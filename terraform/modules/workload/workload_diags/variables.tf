variable "workspace_id" {
  description = "Log Analytics workspace resource ID."
  type        = string
}

variable "resource_ids" {
  description = "Resource IDs to configure diagnostic settings on."
  type        = list(string)
}

variable "log_categories" {
  description = "Log categories to enable."
  type        = list(string)
  default     = ["AuditEvent", "AllLogs"]
}

variable "metric_categories" {
  description = "Metric categories to enable."
  type        = list(string)
  default     = ["AllMetrics"]
}
