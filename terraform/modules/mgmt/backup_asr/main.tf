/**
 * Module: mgmt/backup_asr
 * Purpose: Recovery Services Vault and a default VM backup policy.
 * Scope: Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_recovery_services_vault" "rsv" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.vault_sku
  storage_mode_type   = var.storage_mode_type
  soft_delete_enabled = true
  tags                = var.tags
}

resource "azurerm_backup_policy_vm" "vm" {
  name                = var.policy_name
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.rsv.name

  # Backup schedule
  backup {
    frequency = var.backup_frequency        # Daily or Weekly
    time      = var.backup_time_utc         # HH:MM, UTC
  }

  # Retention ranges
  retention_daily {
    count = var.retention_daily_count
  }

  retention_weekly {
    count    = var.retention_weekly_count
    weekdays = var.retention_weekly_weekdays
  }

  retention_monthly {
    count    = var.retention_monthly_count
    weekdays = var.retention_monthly_weekdays
    weeks    = var.retention_monthly_weeks
  }

  retention_yearly {
    count    = var.retention_yearly_count
    weekdays = var.retention_yearly_weekdays
    weeks    = var.retention_yearly_weeks
    months   = var.retention_yearly_months
  }

  instant_restore_retention_days = var.instant_restore_retention_days
}
