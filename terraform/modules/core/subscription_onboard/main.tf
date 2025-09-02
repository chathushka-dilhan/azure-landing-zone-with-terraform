/**
 * Module: core/subscription_onboard
 * Purpose: Associate an existing subscription to a Management Group and set tags at subscription scope.
 * Scope: Tenant for association, Subscription for tags
 *
 * Notes:
 * - Association uses azurerm_management_group_subscription_association.
 * - Subscription tags use azapi to call Microsoft.Resources/tags at subscription scope.
 */

terraform {
  required_version = ">= 1.5.0"
}

# Associate subscription to the target management group
resource "azurerm_management_group_subscription_association" "assoc" {
  management_group_id = "/providers/Microsoft.Management/managementGroups/${var.management_group_id}"
  subscription_id     = "/subscriptions/${var.subscription_id}"
}

# Apply subscription-level tags only when provided
# AzureRM provider does not expose a first-class subscription tags resource
# Use AzAPI to call Microsoft.Resources/tags at the subscription scope
resource "azapi_resource" "subscription_tags" {
  count = length(var.tags) > 0 ? 1 : 0

  type      = "Microsoft.Resources/tags@2021-04-01"
  name      = "default"
  parent_id = "/subscriptions/${var.subscription_id}"

  body = jsonencode({
    properties = {
      tags = var.tags
    }
  })
}
