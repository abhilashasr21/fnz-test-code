data "azurerm_subscription" "current" {
}

resource "azurerm_resource_group" "test" {
  name     = "${var.app_name}-rg-01"
  location = var.location
}

module "keyvault" {
  source                        = "./Module/keyvault"
  tenant_id                     = data.azurerm_subscription.current.tenant_id
  location                      = var.location
  name                          = "${var.app_name}-keyvault01"
  resource_group_name           = azurerm_resource_group.test.name
  public_network_access_enabled = false
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "${var.app_name}-vnet-01"
  location            = var.location
  resource_group_name = azurerm_resource_group.test.name
  address_space       = var.vnet_address_range
}

resource "azurerm_subnet" "subnet01" {
  name                 = "${var.app_name}-subnet01"
  resource_group_name  = azurerm_resource_group.test.name
  virtual_network_name = azurerm_virtual_network.vnet01.name
  address_prefixes     = var.subnet_address_range

}

resource "azurerm_application_security_group" "asg01" {
  location            = var.location
  name                = "${var.app_name}-asg01"
  resource_group_name = azurerm_resource_group.test.name
}

# module "pep01" {
#   source                          = "./Module/Private Endpoint"
#   private_connection_resource_id  = module.keyvault.resourceid
#   location                        = var.location
#   name                            = "pep01"
#   resource_group_name             = azurerm_resource_group.test.name
#   subnet_resource_id              = azurerm_subnet.subnet01.id
#   network_interface_name          = "pep01-nic"
#   private_service_connection_name = "pep01-psc"
#   subresource_names               = ["vault"]
#   # application_security_group_association_ids = [azurerm_application_security_group.asg01.id]
#   asg_id = azurerm_application_security_group.asg01.id
#   private_dns_zone_group_name = "dnszone-pep01"
#   private_dns_zone_resource_ids = [ "${module.pdz.private_dns_zone_ids}" ]
#   depends_on = [
#     azurerm_resource_group.test,
#     azurerm_virtual_network.vnet01,
#     azurerm_subnet.subnet01,
#     azurerm_application_security_group.asg01,
#     module.pdz,
#     module.keyvault
#   ]
# }

# module "pdz" {
#   source              = "./Module/Private DNS Zone"
#   domain_name         = "privatelink.vaultcore.azure.net"
#   resource_group_name = azurerm_resource_group.test.name
#   virtual_network_links = {
#     vnet01 = {
#       virtual_network_id = azurerm_virtual_network.vnet01.id
#     }
#   }
# }