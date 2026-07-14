variable "name" {
  type        = string
  description = "unique ID"
}

variable "display_name" {
  type        = string
  description = "Display name of Mangament group"
}

variable "parent_management_group_id" {
  type = string
  default = "null"
}

resource "azurerm_management_group" "this" {
  name                       = var.name
  display_name               = var.display_name
  parent_management_group_id = "/providers/Microsoft.Management/managementGroups/${var.parent_management_group_id}"
}