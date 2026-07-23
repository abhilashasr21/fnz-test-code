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

  dynamic "security_rule" {
    for_each = each.value.security_rule
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each                  = var.subnets
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
  depends_on                = [azurerm_network_security_group.nsg]
}

# Create a route table only for subnets that define one
resource "azurerm_route_table" "rt" {
  for_each = {
    for k, v in var.subnets : k => v
    if v.route_table != null
  }

  name                          = each.value.route_table.name
  resource_group_name           = var.resource_group
  location                      = var.location
  bgp_route_propagation_enabled = each.value.route_table.bgp_route_propagation_enabled

  dynamic "route" {
    for_each = each.value.route_table.routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }

  depends_on = [azurerm_virtual_network.vnet]
}

# Associate the route table with its subnet
resource "azurerm_subnet_route_table_association" "rt_association" {
  for_each = {
    for k, v in var.subnets : k => v
    if v.route_table != null
  }

  subnet_id      = azurerm_subnet.subnet[each.key].id
  route_table_id = azurerm_route_table.rt[each.key].id

  depends_on = [azurerm_route_table.rt]
}