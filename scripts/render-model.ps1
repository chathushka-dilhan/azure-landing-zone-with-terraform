<#
.SYNOPSIS
  Renders workload YAML models into Terraform *.auto.tfvars.json files.

.DESCRIPTION
  Reads all *.yaml|*.yml files under -ModelPath, validates minimal schema,
  and writes flattened JSON to -OutDir as <model-name>.auto.tfvars.json.

  The JSON is generic. It preserves keys such as diagnostics, security, rbac, and workload.
  Your workload stack or pipeline can consume these as variables.

.EXAMPLE
  ./scripts/render-model.ps1 -ModelPath "terraform/landing-zones/models/samples" -OutDir "out/params"
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory=$true)]
  [string]$ModelPath,

  [Parameter(Mandatory=$true)]
  [string]$OutDir
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Ensure-ModulePath {
  param([string]$Path)
  if (-not (Test-Path -Path $Path)) {
    throw "Path not found: $Path"
  }
}

function Ensure-OutDir {
  param([string]$Path)
  if (-not (Test-Path -Path $Path)) {
    New-Item -ItemType Directory -Path $Path | Out-Null
  }
}

function Validate-Model {
  param([hashtable]$Model, [string]$File)

  $required = @("name", "tier", "env", "location", "workload")
  foreach ($k in $required) {
    if (-not $Model.ContainsKey($k) -or [string]::IsNullOrWhiteSpace([string]$Model[$k])) {
      throw "Model $File missing required field '$k'."
    }
  }
  if (-not ($Model.workload -is [hashtable])) {
    throw "Model $File has invalid 'workload' section."
  }
}

function ConvertTo-Canonical {
  param([hashtable]$Model)

  # Produce a stable, predictable JSON shape for Terraform tfvars.
  $obj = [ordered]@{
    name         = $Model.name
    tier         = $Model.tier
    env          = $Model.env
    location     = $Model.location
    connectivity = $Model.connectivity
    diagnostics  = $Model.diagnostics
    security     = $Model.security
    rbac         = $Model.rbac
    workload     = $Model.workload
  }
  return $obj
}

# Main
Ensure-ModulePath -Path $ModelPath
Ensure-OutDir -Path $OutDir

# Use built-in ConvertFrom-Yaml (PowerShell 7+)
$files = Get-ChildItem -Path $ModelPath -Recurse -Include *.yaml, *.yml
if ($files.Count -eq 0) {
  Write-Warning "No YAML model files found under $ModelPath."
  exit 0
}

foreach ($f in $files) {
  Write-Host "Processing $($f.FullName)" -ForegroundColor Cyan
  $model = Get-Content -Path $f.FullName -Raw | ConvertFrom-Yaml -NoAlias
  $ht = @{}
  # Convert PSObject to Hashtable for uniform handling
  $model.PSObject.Properties | ForEach-Object { $ht[$_.Name] = $_.Value }

  Validate-Model -Model $ht -File $f.FullName
  $canon = ConvertTo-Canonical -Model $ht

  $outFile = Join-Path $OutDir ("{0}.auto.tfvars.json" -f $canon.name)
  $json = $canon | ConvertTo-Json -Depth 20
  Set-Content -Path $outFile -Value $json -Encoding UTF8

  Write-Host "Wrote $outFile" -ForegroundColor Green
}

Write-Host "Done." -ForegroundColor Green
