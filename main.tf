module "networking" {
  source                           = "./Module/network"
  for_each                         = var.networking
  vnet_name                        = each.value.vnet_name
  resource_group                   = each.value.resource_group
  resource_group_creation_required = each.value.resource_group_creation_required
  address_space                    = each.value.address_space
  location                         = each.value.location
  subnets                          = each.value.subnets

}