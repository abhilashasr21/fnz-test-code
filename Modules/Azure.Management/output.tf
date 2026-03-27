output "management_groups" {
  description = "Created management groups"
  value = {
    for k, v in azurerm_management_group.management_group : k => {
      id           = v.id
      display_name = v.display_name
    }
  }
}
