variable "resource_group_creation_required" {
  type    = bool
  default = false
}

#Virtual Network Variables

variable "vnet_name" {
  type = string
}
variable "resource_group" {
  type = string
}
variable "address_space" {
  type = list(string)
}
variable "location" {
  type = string
}

#Subnet Variables
variable "subnets" {
  type = map(object({
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
  }))
  default = {}
}
