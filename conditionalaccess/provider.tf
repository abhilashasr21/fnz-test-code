terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.8.0"
    }
  }
  backend "remote" {}
}
 
provider "azuread" {
  tenant_id = var.tenant_id
}
 