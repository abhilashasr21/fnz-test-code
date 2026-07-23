variable "networking" {
  description = "A map of networking configurations"
  type = map(object({
    vnet_name                        = string
    address_space                    = list(string)
    location                         = string
    resource_group                   = string
    resource_group_creation_required = bool
    subnets = map(object({
      name             = string
      address_prefixes = list(string)
      nsg_name         = string
      security_rule = list(object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
      }))
      # Optional route table for this subnet
      route_table = optional(object({
        name                          = string
        bgp_route_propagation_enabled = optional(bool, true)
        routes = list(object({
          name                   = string
          address_prefix         = string
          next_hop_type          = string
          next_hop_in_ip_address = optional(string)
        }))
      }))
    }))
  }))
}