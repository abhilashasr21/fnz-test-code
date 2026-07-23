terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0, < 4.0.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfsttaate"
    storage_account_name = "tfstatemgmtimporttest"
    container_name       = "container"
    key                  = "network.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
}