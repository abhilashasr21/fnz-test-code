# output "management_groups" {
#   description = "Created management groups"
#   value = {
#     for k, v in azurerm_management_group.management_group : k => {
#       id           = v.id
#       display_name = v.display_name
#     }
#   }
# }

output "management_group_id" {
  value = azurerm_management_group.management_group_parent.id
}