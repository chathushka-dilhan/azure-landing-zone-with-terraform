# Inputs for terraform/platform/40-management

resource_group_name = "rg-mgmt-dev"
location            = "southeastasia"

log_analytics = {
  name              = "law-mgmt-dev"
  sku               = "PerGB2018"
  retention_in_days = 60
  daily_quota_gb    = 0
  tags = {
    env = "dev"
  }
}

action_group = {
  name       = "ag-platops-dev"
  short_name = "platops"
  email_receivers = [
    { name = "ops",   email_address = "platform-ops@contoso.com" },
    { name = "sec",   email_address = "security@contoso.com" }
  ]
  webhook_receivers = []
  tags = {
    env = "dev"
  }
}

dcr = {
  name        = "dcr-baseline-dev"
  description = "Baseline DCR to LAW"
  tags = {
    env = "dev"
  }
}

backup = {
  name                          = "rsv-mgmt-dev"
  policy_name                   = "DefaultDailyPolicy"
  vault_sku                     = "Standard"
  storage_mode_type             = "GeoRedundant"
  backup_frequency              = "Daily"
  backup_time_utc               = "22:00"
  backup_timezone               = "UTC"
  retention_daily_count         = 30
  retention_weekly_count        = 12
  retention_weekly_weekdays     = ["Saturday"]
  retention_monthly_count       = 12
  retention_monthly_weekdays    = ["Saturday"]
  retention_monthly_weeks       = ["First"]
  retention_yearly_count        = 5
  retention_yearly_weekdays     = ["Saturday"]
  retention_yearly_weeks        = ["First"]
  retention_yearly_months       = ["January"]
  instant_restore_retention_days= 5
  tags = {
    env = "dev"
  }
}
