terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "sttfstateprod001"
    container_name       = "state"
    key                  = "platform/20-identity.tfstate"
    use_azuread_auth     = true
  }
}
