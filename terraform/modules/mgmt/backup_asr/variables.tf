variable "name" {
  description = "Recovery Services Vault name."
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

variable "vault_sku" {
  description = "Vault SKU. Standard or RS0."
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "RS0"], var.vault_sku)
    error_message = "vault_sku must be Standard or RS0."
  }
}

variable "storage_mode_type" {
  description = "Storage mode. GeoRedundant, LocallyRedundant, ZoneRedundant."
  type        = string
  default     = "GeoRedundant"
  validation {
    condition     = contains(["GeoRedundant", "LocallyRedundant", "ZoneRedundant"], var.storage_mode_type)
    error_message = "storage_mode_type must be GeoRedundant, LocallyRedundant, or ZoneRedundant."
  }
}

variable "policy_name" {
  description = "Backup policy name."
  type        = string
  default     = "DefaultDailyPolicy"
}

variable "backup_frequency" {
  description = "Backup frequency. Daily or Weekly."
  type        = string
  default     = "Daily"
  validation {
    condition     = contains(["Daily", "Weekly"], var.backup_frequency)
    error_message = "backup_frequency must be Daily or Weekly."
  }
}

variable "backup_time_utc" {
  description = "Backup time in UTC, format HH:MM."
  type        = string
  default     = "22:00"
}

variable "backup_timezone" {
  description = "Time zone for backups."
  type        = string
  default     = "UTC"
}

variable "retention_daily_count" {
  description = "Daily retention count."
  type        = number
  default     = 30
}

variable "retention_weekly_count" {
  description = "Weekly retention count."
  type        = number
  default     = 12
}

variable "retention_weekly_weekdays" {
  description = "Weekdays for weekly retention."
  type        = list(string)
  default     = ["Saturday"]
}

variable "retention_monthly_count" {
  description = "Monthly retention count."
  type        = number
  default     = 12
}

variable "retention_monthly_weekdays" {
  description = "Weekdays used for monthly retention."
  type        = list(string)
  default     = ["Saturday"]
}

variable "retention_monthly_weeks" {
  description = "Weeks used for monthly retention, e.g., First, Second, Third, Fourth, Last."
  type        = list(string)
  default     = ["First"]
}

variable "retention_yearly_count" {
  description = "Yearly retention count."
  type        = number
  default     = 5
}

variable "retention_yearly_weekdays" {
  description = "Weekdays used for yearly retention."
  type        = list(string)
  default     = ["Saturday"]
}

variable "retention_yearly_weeks" {
  description = "Weeks used for yearly retention."
  type        = list(string)
  default     = ["First"]
}

variable "retention_yearly_months" {
  description = "Months used for yearly retention."
  type        = list(string)
  default     = ["January"]
}

variable "instant_restore_retention_days" {
  description = "Instant restore retention for snapshots."
  type        = number
  default     = 5
}

variable "tags" {
  description = "Resource tags for the vault."
  type        = map(string)
  default     = {}
}
