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
  }))
  default = {}
}
