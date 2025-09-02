/**
 * Root: 10-policy
 * Purpose: Deploy policy definitions, initiatives, and assignments at MG scopes.
 * Notes:
 * - Keeps JSON source of truth under policy/definitions and policy/initiatives.
 */

terraform {
  required_version = ">= 1.5.0"
}

# --------------------------
# Policy Definitions (Built-ins via references + few custom)
# --------------------------

# Custom: Allowed Locations (sample custom wrapper for clarity)
locals {
  def_allowed_locations_json = jsondecode(file("${path.module}/policy/definitions/allowed-locations.json"))
  def_deny_public_ip_json    = jsondecode(file("${path.module}/policy/definitions/deny-public-ip.json"))
}

resource "azurerm_policy_definition" "allowed_locations" {
  name         = local.def_allowed_locations_json.name
  policy_type  = "Custom"
  mode         = "All"
  display_name = local.def_allowed_locations_json.properties.displayName
  description  = local.def_allowed_locations_json.properties.description
  policy_rule  = local.def_allowed_locations_json.properties.policyRule
  parameters   = local.def_allowed_locations_json.properties.parameters
  metadata     = local.def_allowed_locations_json.properties.metadata
}

resource "azurerm_policy_definition" "deny_public_ip" {
  name         = local.def_deny_public_ip_json.name
  policy_type  = "Custom"
  mode         = "Indexed"
  display_name = local.def_deny_public_ip_json.properties.displayName
  description  = local.def_deny_public_ip_json.properties.description
  policy_rule  = local.def_deny_public_ip_json.properties.policyRule
  parameters   = local.def_deny_public_ip_json.properties.parameters
  metadata     = local.def_deny_public_ip_json.properties.metadata
}

# --------------------------
# Initiative (Policy Set Definition)
# --------------------------
locals {
  initiative_platform = jsondecode(file("${path.module}/policy/initiatives/platform-baseline.json"))
}

resource "azurerm_policy_set_definition" "platform_baseline" {
  name         = local.initiative_platform.name
  policy_type  = "Custom"
  display_name = local.initiative_platform.properties.displayName
  description  = local.initiative_platform.properties.description
  metadata     = local.initiative_platform.properties.metadata

  # Reference the created definitions
  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.allowed_locations.id
    reference_id         = "AllowedLocations"
    parameter_values     = jsonencode({
      listOfAllowedLocations = { value = var.allowed_locations }
    })
  }

  policy_definition_reference {
    policy_definition_id = azurerm_policy_definition.deny_public_ip.id
    reference_id         = "DenyPublicIP"
    parameter_values     = jsonencode({
      effect = { value = var.deny_public_ip_effect }
    })
  }
}

# --------------------------
# Assignments at MG scopes
# --------------------------
resource "azurerm_management_group_policy_assignment" "platform_baseline_platform" {
  name                 = "platform-baseline-platform"
  management_group_id  = var.management_group_ids.platform
  policy_definition_id = azurerm_policy_set_definition.platform_baseline.id
  parameters           = jsonencode({})
  enforce              = true
}

resource "azurerm_management_group_policy_assignment" "platform_baseline_corp" {
  name                 = "platform-baseline-corp"
  management_group_id  = var.management_group_ids.corp
  policy_definition_id = azurerm_policy_set_definition.platform_baseline.id
  parameters           = jsonencode({})
  enforce              = true
}

resource "azurerm_management_group_policy_assignment" "platform_baseline_online" {
  name                 = "platform-baseline-online"
  management_group_id  = var.management_group_ids.online
  policy_definition_id = azurerm_policy_set_definition.platform_baseline.id
  parameters           = jsonencode({})
  enforce              = true
}
