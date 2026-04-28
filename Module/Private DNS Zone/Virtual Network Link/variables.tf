variable "name" {
    type        = string
  description = "The name of the virtual network link."

  validation {
    condition     = length(var.name) > 0
    error_message = "The name must not be empty."
  }
}

variable "resource_group_name" {
  type = string
}

variable "private_dns_zone_name" {
  type = string
}

variable "virtual_network_id" {
  type        = string
  description = "The ID of the virtual network to link to the private DNS zone."

  validation {
    condition     = length(var.virtual_network_id) > 0
    error_message = "The virtual_network_id must not be empty."
  }
  validation {
    condition     = can(regex("^/subscriptions/[a-fA-F0-9-]+/resourceGroups/[a-zA-Z0-9-_.()]+/providers/Microsoft.Network/virtualNetworks/[a-zA-Z0-9-_.]+$", var.virtual_network_id))
    error_message = "The virtual_network_id must be a valid Azure Virtual Network resource ID."
  }
}

variable "registration_enabled" {
  type = bool
  default = false
}

variable "tags" {
  type = map(string)
  default = { }
}