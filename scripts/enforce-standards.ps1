<#
.SYNOPSIS
  Runs Terraform formatting, validation, tflint, and tfsec across the repo.

.DESCRIPTION
  - terraform fmt -check -recursive
  - terraform validate with -backend=false in each root stack
  - tflint if available
  - tfsec if available

.NOTES
  Requires Terraform in PATH. tflint and tfsec are optional but recommended.
#>

[CmdletBinding()]
param(
  [switch]$Fix # run 'terraform fmt -recursive' instead of check
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Invoke-Cmd {
  param([string]$Command, [string]$WorkingDir)
  Push-Location $WorkingDir
  try {
    Write-Host "[$WorkingDir] $Command" -ForegroundColor DarkCyan
    iex $Command
  } finally {
    Pop-Location
  }
}

# 1) terraform fmt
if ($Fix) {
  terraform fmt -recursive
} else {
  terraform fmt -check -recursive
}

# Root stacks to validate
$roots = @(
  "terraform/platform/00-tenant",
  "terraform/platform/10-policy",
  "terraform/platform/20-identity",
  "terraform/platform/30-connectivity",
  "terraform/platform/40-management",
  "terraform/platform/50-security",
  "terraform/landing-zones/vending",
  "terraform/landing-zones/baselines/corp",
  "terraform/landing-zones/baselines/online"
)

foreach ($root in $roots) {
  if (-not (Test-Path $root)) { continue }
  Invoke-Cmd -WorkingDir $root -Command "terraform init -backend=false -input=false"
  Invoke-Cmd -WorkingDir $root -Command "terraform validate"
}

# 2) tflint (if installed)
if (Get-Command tflint -ErrorAction SilentlyContinue) {
  Write-Host "Running tflint..." -ForegroundColor Cyan
  tflint --recursive
} else {
  Write-Warning "tflint not found. Skipping."
}

# 3) tfsec (if installed)
if (Get-Command tfsec -ErrorAction SilentlyContinue) {
  Write-Host "Running tfsec..." -ForegroundColor Cyan
  tfsec --soft-fail .
} else {
  Write-Warning "tfsec not found. Skipping."
}

Write-Host "Standards check complete." -ForegroundColor Green
