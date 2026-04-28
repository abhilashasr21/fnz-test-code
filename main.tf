data "azurerm_subscription" "current" {
}

variable "location" {
  type = string
  default = "ukwest"
}

resource "azurerm_resource_group" "test" {
  name = "kv-test-rg"
  location = var.location
}

module "keyvault" {
  source = "./Module/keyvault"
  tenant_id = data.azurerm_subscription.current.tenant_id
  location = var.location
  name = "testfnz01"
  resource_group_name = azurerm_resource_group.test.name
}