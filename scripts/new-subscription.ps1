<#
.SYNOPSIS
  Creates a new Azure subscription using Subscription Alias API, then outputs the subscriptionId.

.DESCRIPTION
  Uses 'az rest' to call Microsoft.Subscription/aliases.
  Requires appropriate billing permissions and an authenticated Azure CLI session.
  On success, prints the new subscription GUID.

.EXAMPLE
  ./scripts/new-subscription.ps1 `
    -AliasName "lz-sub-dev01" `
    -DisplayName "LZ Dev 01" `
    -BillingScopeId "/providers/Microsoft.Billing/billingAccounts/xxx:yyy/billingProfiles/bbb/invoiceSections/ccc" `
    -Workload "DevTest"
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)]
  [string]$AliasName,

  [Parameter(Mandatory=$true)]
  [string]$DisplayName,

  [Parameter(Mandatory=$true)]
  [string]$BillingScopeId,

  [ValidateSet("Production","DevTest")]
  [string]$Workload = "Production"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Check Azure CLI
if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
  throw "Azure CLI 'az' not found in PATH."
}

$body = @{
  properties = @{
    workload              = $Workload
    displayName           = $DisplayName
    billingScope          = $BillingScopeId
    subscriptionAliasName = $AliasName
  }
} | ConvertTo-Json -Depth 5

Write-Host "Creating subscription alias '$AliasName'..." -ForegroundColor Cyan
$resp = az rest `
  --method put `
  --uri "https://management.azure.com/providers/Microsoft.Subscription/aliases/$AliasName?api-version=2020-09-01" `
  --headers "Content-Type=application/json" `
  --body $body | ConvertFrom-Json

if (-not $resp.properties.subscriptionId) {
  throw "Subscription creation did not return a subscriptionId. Response: $($resp | ConvertTo-Json -Depth 5)"
}

$subId = $resp.properties.subscriptionId
Write-Host "Created subscription: $subId" -ForegroundColor Green
$subId
