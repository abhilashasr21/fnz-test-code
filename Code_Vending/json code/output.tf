output "level_0_management_groups" {
  value = {
    for k, v in azurerm_management_group.level_0 : k => v.id
  }
}

output "level_1_management_groups" {
  value = {
    for k, v in azurerm_management_group.level_1 : k => v.id
  }
}

output "level_2_management_groups" {
  value = {
    for k, v in azurerm_management_group.level_2 : k => v.id
  }
}

output "level_3_management_groups" {
  value = {
    for k, v in azurerm_management_group.level_3 : k => v.id
  }
}