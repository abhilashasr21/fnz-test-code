resource "azurerm_private_dns_zone" "this" {
  name                = var.domain_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

module "virtual_network_link" {
  source                = "./Virtual Network Link"
  for_each              = var.virtual_network_links
  name                  = "${azurerm_private_dns_zone.this.name}-link"
  resource_group_name   = azurerm_private_dns_zone.this.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  virtual_network_id    = each.value.virtual_network_id != null ? each.value.virtual_network_id : null
}

