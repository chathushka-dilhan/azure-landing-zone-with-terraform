/**
 * Module: security/defender_plans
 * Purpose: Configure Microsoft Defender for Cloud plans and agent auto provisioning.
 * Scope: Subscription
 */

terraform {
  required_version = ">= 1.5.0"
}

# Auto provisioning of the Log Analytics agent for classic scenarios.
# Keep On for broad coverage. AMA-based collection is configured via DCRs.
resource "azurerm_security_center_auto_provisioning" "auto" {
  auto_provision = var.auto_provisioning_on ? "On" : "Off"
}

# Optional security contact
resource "azurerm_security_center_contact" "contact" {
  name = var.contact_name != "" ? var.contact_name : "Security Contact"
  count                         = var.contact_email != "" ? 1 : 0
  email                         = var.contact_email
  phone                         = var.contact_phone
  alert_notifications           = var.alert_notifications
  alerts_to_admins              = var.alerts_to_subscription_owners
}

# Plan enablement per resource type
# Map example:
# { VirtualMachines = "Standard", StorageAccounts = "Standard", KeyVaults = "Free" }
resource "azurerm_security_center_subscription_pricing" "plan" {
  for_each      = var.plans
  tier          = each.value
  resource_type = each.key
}
