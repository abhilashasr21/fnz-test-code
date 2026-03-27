# resource "azurerm_management_group" "parent_group" {
#   count        = var.parent_id == null ? 1 : 0
#   display_name = var.display_name
#   # other subscription IDs can go here
  
# }

resource "azurerm_management_group" "management_group" {
  for_each = var.management_groups
  display_name               = each.value.display_name
  parent_management_group_id = each.value.parent_id != null ? each.value.parent_id : null
}



