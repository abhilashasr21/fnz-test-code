terraform {
  required_version = ">= 1.5.0, < 2.0.0"
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~> 2.4"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
  }
}
}
# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
provider "azapi" {
}

provider "azurerm" {
  features {}
#   skip_provider_registration = true
}