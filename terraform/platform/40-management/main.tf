/**
 * Root: 40-management
 * Purpose: Deploy platform monitoring, action groups, DCR, and backup vault.
 */

terraform {
  required_version = ">= 1.5.0"
}

module "law" {
  source              = "../../modules/mgmt/log_analytics"
  name                = var.log_analytics.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = try(var.log_analytics.sku, "PerGB2018")
  retention_in_days   = try(var.log_analytics.retention_in_days, 60)
  daily_quota_gb      = try(var.log_analytics.daily_quota_gb, 0)
  tags                = try(var.log_analytics.tags, {})
}

module "ag" {
  source              = "../../modules/mgmt/action_groups"
  name                = var.action_group.name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group.short_name
  email_receivers     = try(var.action_group.email_receivers, [])
  webhook_receivers   = try(var.action_group.webhook_receivers, [])
  tags                = try(var.action_group.tags, {})
}

module "dcr" {
  source              = "../../modules/mgmt/monitor_baseline"
  name                = var.dcr.name
  resource_group_name = var.resource_group_name
  location            = var.location
  workspace_id        = module.law.workspace_id
  description         = try(var.dcr.description, "Baseline DCR")
  tags                = try(var.dcr.tags, {})
}

module "backup" {
  source                         = "../../modules/mgmt/backup_asr"
  name                           = var.backup.name
  resource_group_name            = var.resource_group_name
  location                       = var.location
  policy_name                    = try(var.backup.policy_name, "DefaultDailyPolicy")
  vault_sku                      = try(var.backup.vault_sku, "Standard")
  storage_mode_type              = try(var.backup.storage_mode_type, "GeoRedundant")
  backup_frequency               = try(var.backup.backup_frequency, "Daily")
  backup_time_utc                = try(var.backup.backup_time_utc, "22:00")
  backup_timezone                = try(var.backup.backup_timezone, "UTC")
  retention_daily_count          = try(var.backup.retention_daily_count, 30)
  retention_weekly_count         = try(var.backup.retention_weekly_count, 12)
  retention_weekly_weekdays      = try(var.backup.retention_weekly_weekdays, ["Saturday"])
  retention_monthly_count        = try(var.backup.retention_monthly_count, 12)
  retention_monthly_weekdays     = try(var.backup.retention_monthly_weekdays, ["Saturday"])
  retention_monthly_weeks        = try(var.backup.retention_monthly_weeks, ["First"])
  retention_yearly_count         = try(var.backup.retention_yearly_count, 5)
  retention_yearly_weekdays      = try(var.backup.retention_yearly_weekdays, ["Saturday"])
  retention_yearly_weeks         = try(var.backup.retention_yearly_weeks, ["First"])
  retention_yearly_months        = try(var.backup.retention_yearly_months, ["January"])
  instant_restore_retention_days = try(var.backup.instant_restore_retention_days, 5)
  tags                           = try(var.backup.tags, {})
}
