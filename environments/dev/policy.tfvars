# Inputs for terraform/platform/10-policy
# Note: fill these IDs from 00-tenant outputs during CI/CD.
# Using literal placeholders here for local testing.

management_group_ids = {
  platform     = "/providers/Microsoft.Management/managementGroups/contoso-platform"
  security     = "/providers/Microsoft.Management/managementGroups/contoso-security"
  management   = "/providers/Microsoft.Management/managementGroups/contoso-management"
  connectivity = "/providers/Microsoft.Management/managementGroups/contoso-connectivity"
  identity     = "/providers/Microsoft.Management/managementGroups/contoso-identity"
  landingzones = "/providers/Microsoft.Management/managementGroups/contoso-landingzones"
  corp         = "/providers/Microsoft.Management/managementGroups/contoso-lz-corp"
  online       = "/providers/Microsoft.Management/managementGroups/contoso-lz-online"
}

policy_tags = {
  env       = "dev"
  managedBy = "terraform"
}

allowed_locations      = ["southeastasia", "eastasia"]
deny_public_ip_effect  = "Deny"

# Optionally pass a LAW ID if your initiatives reference it.
# Example: "/subscriptions/<sub>/resourceGroups/rg-mgmt-dev/providers/Microsoft.OperationalInsights/workspaces/law-mgmt-dev"
log_analytics_workspace_id = ""
