variable "name" {
  description = "Data Collection Rule name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Region."
  type        = string
}

variable "workspace_id" {
  description = "Log Analytics workspace resource ID."
  type        = string
}

variable "description" {
  description = "Optional description."
  type        = string
  default     = "Baseline DCR routing perf and syslog to Log Analytics."
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
