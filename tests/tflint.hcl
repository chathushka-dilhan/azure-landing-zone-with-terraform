# TFLint configuration for AzureRM
# Docs: https://github.com/terraform-linters/tflint

plugin "azurerm" {
  enabled = true
  version = "0.27.1" # pick a recent stable
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

config {
  format = "compact"
}

rule "terraform_required_version" {
  enabled = true
}

rule "terraform_standard_module_structure" {
  enabled = true
}

# AzureRM rules
rule "azurerm_resource_group_name"        { enabled = true }
rule "azurerm_virtual_network_name"       { enabled = true }
rule "azurerm_subnet_name"                { enabled = true }
rule "azurerm_storage_account_name"       { enabled = true }
rule "azurerm_key_vault_name"             { enabled = true }

# You can ignore paths like vendor or generated folders
ignore_paths = [
  ".terraform/",
  "out/",
  "bin/"
]
