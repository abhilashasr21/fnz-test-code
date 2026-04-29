# Configure Terraform to use the Azure provider

terraform {
  required_version = ">= 1.5.0, < 2.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.80.0, < 4.0.0"
    }
  }

  backend "remote" {
    hostname     = "fnztrial.jfrog.io"
    organization = "bu001"
    workspaces {
      name = "mgmt"
    }
  }


}

# Configure the Microsoft Azure Provider 
provider "azurerm" {
  features {}
  # skip_provider_registration = true
}
