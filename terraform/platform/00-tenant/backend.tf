/**
 * Remote state backend for the 00-tenant stack.
 * Replace the placeholders before running `terraform init`.
 */
 
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstateprod001"   # must be globally unique
    container_name       = "state"
    key                  = "platform/00-tenant.tfstate"
    use_azuread_auth     = true
  }
}
