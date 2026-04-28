resource "azurerm_private_dns_zone" "this" {
  name                = var.domain_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# module "virtual_network_link" {
#   source              = "./Virtual Network Link"
#   for_each            = var.virtual_network_links
#   name                = "${var.domain_name}-link"
#   resource_group_name = var.resource_group_name
#   virtual_network_id  = var.virtual_network_id
#   private_dns_zone_id = azurerm_private_dns_zone.this.id
#   tags                = var.tags
  
# }

