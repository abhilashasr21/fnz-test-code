# Configure Terraform to use the Azure provider

terraform {
  # required_version = ">= 1.5.0, < 2.0.0"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      # version = ">= 3.80.0, < 4.0.0"
    }

  }

  backend "azurerm" {
    resource_group_name  = "tfsttaate"
    storage_account_name = "tfstatemgmtimporttest"
    container_name       = "container"
    key                  = "mgmtarmmodule.tfstate"
    use_azuread_auth     = true
    tenant_id            = "48d31bc6-3359-4e9d-af8b-75b9b41ebd66"
    subscription_id      = "f3e5c1d0-4b7a-4f8e-9c6e-2b1e5c1d0f3e"
  }
}

# Configure the Microsoft Azure Provider 
provider "azurerm" {
  features {}
}

# provider "azapi" {
# }