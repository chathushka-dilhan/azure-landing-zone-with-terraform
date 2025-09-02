/**
 * Provider versions and Terraform version constraints.
 * Keep versions pinned for reproducibility across pipelines.
 */
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.114"     # pin to a recent stable
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.13"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.11"
    }
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
  }
}
