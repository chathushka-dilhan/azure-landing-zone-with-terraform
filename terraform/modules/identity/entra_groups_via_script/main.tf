/**
 * Module: identity/entra_groups_via_script
 * Purpose: Create Microsoft Entra groups through a Deployment Script executed with a User Assigned Managed Identity.
 * Scope: Resource Group (script), acts against Entra with Graph under the MI.
 * Notes:
 * - The user assigned identity must have Microsoft Graph permissions to create groups.
 * - Use cautiously and keep idempotent behavior.
 */

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.13.0"
    }
  }
}

locals {
  enabled = var.enabled && length(var.groups) > 0
}

resource "azapi_resource" "deployment_script" {
  count     = local.enabled ? 1 : 0
  type      = "Microsoft.Resources/deploymentScripts@2023-08-01"
  name      = "create-entra-groups"
  parent_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  location  = var.location

  body = jsonencode({
    identity = {
      type                   = "UserAssigned"
      userAssignedIdentities = {
        "${var.user_assigned_identity_id}" = {}
      }
    }
    location = var.location
    kind = "AzurePowerShell"
    properties = {
      azPowerShellVersion = "10.4"
      retentionInterval   = "P1D"
      timeout             = "PT30M"
      arguments           = ""
      scriptContent       = <<'PS1'
        $ErrorActionPreference = "Stop"

        if (-not (Get-Module Microsoft.Graph -ListAvailable)) {
          Install-Module Microsoft.Graph -Force -Scope CurrentUser -AcceptLicense
        }
        Import-Module Microsoft.Graph
        Connect-MgGraph -Identity

        $groups = @()
        $groups = ConvertFrom-Json @'
        ${jsonencode(var.groups)}
'@

        foreach ($g in $groups) {
          $displayName = $g.displayName
          $mailNick    = if ($g.mailNickname) { $g.mailNickname } else { ($displayName -replace "[^a-zA-Z0-9]", "").ToLower() }
          $desc        = $g.description

          $existing = Get-MgGroup -Filter "displayName eq '$displayName'" -All:$true | Select-Object -First 1
          if ($null -eq $existing) {
            New-MgGroup -DisplayName $displayName -MailEnabled:$false -MailNickname $mailNick -SecurityEnabled:$true -Description $desc | Out-Null
            Write-Output "Created group: $displayName"
          } else {
            Write-Output "Group already exists: $displayName"
          }
        }
      PS1
    }
  })

  response_export_values = ["*"]
  tags                   = var.tags
}
