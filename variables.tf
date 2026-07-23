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
    }))
  }))
}