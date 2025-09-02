/**
 * Remote state for subscription vending stack.
 * Replace with your state RG, storage account, and container.
 */
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstateprod001"
    container_name       = "state"
    key                  = "landing-zones/vending.tfstate"
    use_azuread_auth     = true
  }
}
