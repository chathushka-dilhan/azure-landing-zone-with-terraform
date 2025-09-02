variable "resource_group_name" {
  description = "Management RG."
  type        = string
}

variable "location" {
  description = "Region."
  type        = string
}

variable "log_analytics" {
  description = "Workspace settings."
  type = object({
    name              = string
    sku               = optional(string, "PerGB2018")
    retention_in_days = optional(number, 60)
    daily_quota_gb    = optional(number, 0)
    tags              = optional(map(string), {})
  })
}

variable "action_group" {
  description = "Action group settings."
  type = object({
    name            = string
    short_name      = string
    email_receivers = optional(list(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = optional(bool, true)
    })), [])
    webhook_receivers = optional(list(object({
      name                    = string
      service_uri             = string
      use_common_alert_schema = optional(bool, true)
    })), [])
    tags = optional(map(string), {})
  })
}

variable "dcr" {
  description = "Baseline Data Collection Rule settings."
  type = object({
    name        = string
    description = optional(string, "Baseline DCR")
    tags        = optional(map(string), {})
  })
}

variable "backup" {
  description = "Recovery Services Vault and default VM policy."
  type = object({
    name                         = string
    policy_name                  = optional(string, "DefaultDailyPolicy")
    vault_sku                    = optional(string, "Standard")
    storage_mode_type            = optional(string, "GeoRedundant")
    backup_frequency             = optional(string, "Daily")
    backup_time_utc              = optional(string, "22:00")
    backup_timezone              = optional(string, "UTC")
    retention_daily_count        = optional(number, 30)
    retention_weekly_count       = optional(number, 12)
    retention_weekly_weekdays    = optional(list(string), ["Saturday"])
    retention_monthly_count      = optional(number, 12)
    retention_monthly_weekdays   = optional(list(string), ["Saturday"])
    retention_monthly_weeks      = optional(list(string), ["First"])
    retention_yearly_count       = optional(number, 5)
    retention_yearly_weekdays    = optional(list(string), ["Saturday"])
    retention_yearly_weeks       = optional(list(string), ["First"])
    retention_yearly_months      = optional(list(string), ["January"])
    instant_restore_retention_days = optional(number, 5)
    tags                         = optional(map(string), {})
  })
}
