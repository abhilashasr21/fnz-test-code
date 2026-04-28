data "azurerm_subscription" "current" {
}

variable "location" {
  type    = string
  default = "ukwest"
}

resource "azurerm_resource_group" "test" {
  name     = "kv-test-rg"
  location = var.location
}

module "keyvault" {
  source                        = "./Module/keyvault"
  tenant_id                     = data.azurerm_subscription.current.tenant_id
  location                      = var.location
  name                          = "testfnz01"
  resource_group_name           = azurerm_resource_group.test.name
  public_network_access_enabled = false
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "test-vnet-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet01" {
  name                 = "subnet01"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = ["10.0.2.0/24"]

}

resource "azurerm_application_security_group" "asg01" {
  location            = var.location
  name                = "asg01"
  resource_group_name = azurerm_resource_group.test.name
}

module "pep01" {
  source                                     = "./Module/Private Endpoint"
  private_connection_resource_id             = module.keyvault.resourceid
  location                                   = var.location
  name                                       = "pep01"
  resource_group_name                        = azurerm_resource_group.test.name
  subnet_resource_id                         = azurerm_subnet.subnet01.id
  network_interface_name                     = "pep01-nic"
  private_service_connection_name            = "pep01-psc"
  subresource_names                          = ["vault"]
  application_security_group_association_ids = [azurerm_application_security_group.asg01.id]
  depends_on = [
    azurerm_resource_group.test,
    azurerm_virtual_network.vnet01,
    azurerm_subnet.subnet01,
    azurerm_application_security_group.asg01
  ]
}