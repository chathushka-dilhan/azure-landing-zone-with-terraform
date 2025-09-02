/**
 * Stack: landing-zones/vending
 * Purpose: Create or onboard subscriptions, move to target MG, set tags, and assign RBAC.
 * Notes: Creation uses the Subscriptions Alias API via azapi. Requires appropriate tenant/billing permissions.
 */

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azapi = { source = "azure/azapi", version = ">= 1.13.0" }
  }
}

locals {
  do_create = var.create_subscription
}

# Validate inputs
resource "null_resource" "validate" {
  lifecycle {
    precondition {
      condition     = local.do_create ? (var.billing_scope_id != "" && var.display_name != "") : (var.subscription_id != "")
      error_message = "Either provide billing_scope_id and display_name for creation, or subscription_id for onboarding."
    }
  }
}

# Create a new subscription alias (optional)
resource "azapi_resource" "subscription_alias" {
  count     = local.do_create ? 1 : 0
  type      = "Microsoft.Subscription/aliases@2020-09-01"
  name      = var.alias_name
  parent_id = "/providers/Microsoft.Subscription"

  body = jsonencode({
    properties = {
      workload         = var.workload
      displayName      = var.display_name
      billingScope     = var.billing_scope_id
    }
  })

  response_export_values = ["*"]
}

# Resolve subscription id (created or provided)
locals {
  created_subscription_id = try(jsondecode(azapi_resource.subscription_alias[0].output).properties.subscriptionId, null)
  effective_subscription  = local.do_create ? local.created_subscription_id : var.subscription_id
}

# Onboard the subscription under the MG and apply tags
module "onboard" {
  source              = "../../modules/core/subscription_onboard"
  subscription_id     = local.effective_subscription
  management_group_id = var.management_group_id
  tags                = var.tags
}

# Optional RBAC for the new/onboarded subscription
module "rbac" {
  count               = (length(var.rbac_owners) + length(var.rbac_contributors)) > 0 ? 1 : 0
  source              = "../../modules/core/role_assignments"
  scope_type          = "subscription"
  subscription_id     = local.effective_subscription
  owners              = var.rbac_owners
  contributors        = var.rbac_contributors
}
