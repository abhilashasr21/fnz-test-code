# Configure Terraform to use the Azure provider

terraform {
  required_version = ">= 1.5.0, < 2.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0, < 4.0.0"
    }
  }

  backend "azurerm" {
    # resource_group_name  = "my-tfstate-rg"
    # storage_account_name = "mytfstateacct2026"
    # container_name       = "tfstate"
    # key                  = "prod.terraform.tfstate"
  }
}

# Configure the Microsoft Azure Provider 
provider "azurerm" {
  features {}
}
