/**
 * Common provider configuration shared by all stacks.
 * Each root stack can import this file via a relative module or symlink pattern,
 * or you can duplicate these two blocks in each root (simplest).
 */

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
  }

  # If you are using federated credentials in Azure DevOps or GitHub Actions,
  # enable OIDC automatically by setting these env vars:
  # ARM_USE_OIDC=true, ARM_CLIENT_ID, ARM_TENANT_ID, ARM_SUBSCRIPTION_ID
}

provider "azapi" {
  # Inherits Azure auth from azurerm environment variables.
}
