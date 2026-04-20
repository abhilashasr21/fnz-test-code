# Configure Terraform to use the Azure provider

terraform {
  required_version = ">= 1.5.0, < 2.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0, < 4.0.0"
    }
  }

  # backend "azurerm" {
  #   resource_group_name  = "rg-threadservice-tfstate"
  #   storage_account_name = "stthreadtfstate"
  #   container_name       = "tfstate"
  #   key                  = "tf.state.latest.json"
  # }


  backend "remote" {
    hostname     = "fnztrial.jfrog.io"
    organization = "backend-bu001"
    workspaces {
      prefix = "npr"    
    }
  }


}

# Configure the Microsoft Azure Provider 
provider "azurerm" {
  features {}
  # skip_provider_registration = true
}
