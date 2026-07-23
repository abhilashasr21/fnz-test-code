resource "azurerm_resource_group" "rg" {
  count    = var.resource_group_creation_required ? 1 : 0
  name     = var.resource_group
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group
  address_space       = var.address_space
  location            = var.location
  depends_on          = [azurerm_resource_group.rg]
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnets
  name                 = each.value.name
  resource_group_name  = var.resource_group
  virtual_network_name = var.vnet_name
  address_prefixes     = each.value.address_prefixes
  depends_on           = [azurerm_virtual_network.vnet]
}

resource "azurerm_network_security_group" "nsg" {
  for_each            = var.subnets
  resource_group_name = var.resource_group
  location            = var.location
  name                = each.value.nsg_name
  security_rule       = each.value.security_rule
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.subnet[each.value.name].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value.nsg_name].id
  depends_on                = [azurerm_network_security_group.nsg]
}