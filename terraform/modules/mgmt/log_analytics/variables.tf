variable "name" {
  description = "Log Analytics workspace name."
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

variable "sku" {
  description = "Log Analytics SKU."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Retention in days."
  type        = number
  default     = 60
}

variable "daily_quota_gb" {
  description = "Daily ingestion cap in GB. 0 means unlimited."
  type        = number
  default     = 0
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
