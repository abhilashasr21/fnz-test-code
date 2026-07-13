terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
    }
  }
  backend "azurerm" {
    resource_group_name = "tfsttaate"
    storage_account_name = "tfstatemgmtimporttest"
    container_name       = "container"
    key                  = "terraform.tfstate"
  }
}

provider "azapi" {
}