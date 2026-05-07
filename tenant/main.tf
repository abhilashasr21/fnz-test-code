#create Variable for management groups
variable "management_groups" {
  description = "A map of management groups to create. The key is the name of the management group, and the value is an object containing the display name and parent ID."
  type = map(object({
    display_name = string
    parent_id    = string
  }))
}

#create block for management group tf resource
resource "azurerm_management_group" "example" {
for_each    = var.management_groups
  name        = each.key
  display_name = each.value.display_name
  parent_id    = each.value.parent_id != null ? each.value.parent_id : null
}