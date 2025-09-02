terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstateprod001"
    container_name       = "state"
    key                  = "platform/30-connectivity.tfstate"
    use_azuread_auth     = true
  }
}
