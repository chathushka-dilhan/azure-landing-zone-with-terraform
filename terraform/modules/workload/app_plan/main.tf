/**
 * Module: workload/app_plan
 * Purpose: Create an App Service Plan and optionally a Web App with system assigned identity.
 * Scope: Resource Group
 */

terraform {
  required_version = ">= 1.5.0"
}

resource "azurerm_service_plan" "plan" {
  name                = var.plan_name
  resource_group_name = var.resource_group_name
  location            = var.location

  os_type  = "Windows"
  sku_name = var.sku_name
  tags     = var.tags
}

resource "azurerm_windows_web_app" "site" {
  count               = var.create_site ? 1 : 0
  name                = var.site_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true

  site_config {
    ftps_state = "Disabled"
  }

  identity {
    type = var.site_managed_identity ? "SystemAssigned" : "None"
  }

  tags = var.tags
}
