# resource "azurerm_management_group" "management_group" {
#   for_each = var.management_groups
#   display_name               = each.value.display_name
#   parent_management_group_id = each.value.parent_id != null ? each.value.parent_id : null
# }

resource "azurerm_management_group" "management_group" {
  display_name = var.display_name
  parent_management_group_id = var.parent_management_group_id != null ? "/providers/Microsoft.Management/managementGroups/${var.parent_management_group_id}" : null
}


