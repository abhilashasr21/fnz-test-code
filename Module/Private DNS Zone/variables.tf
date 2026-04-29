variable "domain_name" {
  type = string
  description = "(Required) The name of the this resource." 
}

variable "resource_group_name" {
  type = string
  description = "(Required) The name of the resource group in which to create the Private DNS Zone."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags of the resource."
}

variable "virtual_network_links" {
  type = map(object({
    vnetlinkname                           = optional(string, null)
    name                                   = optional(string, null)
    vnetid                                 = optional(string, null)
    virtual_network_id                     = optional(string, null)
    autoregistration                       = optional(bool, false)
    registration_enabled                   = optional(bool, null)
    private_dns_zone_supports_private_link = optional(bool, false)
    resolution_policy                      = optional(string, "Default")
    tags                                   = optional(map(string), null)
  }))
  default     = {}
  description = <<-DESCRIPTION
      A map of objects where each object contains information to create a virtual network link.
      Either `name` or `vnetlinkname` must be provided, and either `virtual_network_id` or `vnetid` must be provided.
    DESCRIPTION

  # validation {
  #   condition     = alltrue([for v in var.virtual_network_links : coalesce(v.name, v.vnetlinkname) != null])
  #   error_message = "Each virtual_network_link must have either vnetlinkname or name provided."
  # }
  validation {
    condition     = alltrue([for v in var.virtual_network_links : coalesce(v.virtual_network_id, v.vnetid) != null])
    error_message = "Each virtual_network_link must have either vnetid or virtual_network_id provided."
  }
  # validation {
  #   condition     = alltrue([for v in var.virtual_network_links : length(coalesce(v.name, v.vnetlinkname)) < 80])
  #   error_message = "Each virtual network link name must have less than 80 characters."
  # }
}