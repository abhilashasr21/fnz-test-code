
resource "azurerm_management_group" "level_0" {
  for_each = {
    for mg in local.level_0 : mg.name => mg
  }

  name         = each.value.name
  display_name = each.value.display_name
}

resource "azurerm_management_group" "level_1" {
  for_each = {
    for mg in local.level_1 : mg.name => mg
  }

  name                       = each.value.name
  display_name               = each.value.display_name
  parent_management_group_id = azurerm_management_group.level_0[each.value.parent_name].id
}

resource "azurerm_management_group" "level_2" {
  for_each = {
    for mg in local.level_2 : mg.name => mg
  }

  name         = each.value.name
  display_name = each.value.display_name

  parent_management_group_id = (
    contains(keys(azurerm_management_group.level_1), each.value.parent_name)
    ? azurerm_management_group.level_1[each.value.parent_name].id
    : azurerm_management_group.level_0[each.value.parent_name].id
  )
}

resource "azurerm_management_group" "level_3" {
  for_each = {
    for mg in local.level_3 : mg.name => mg
  }

  name         = each.value.name
  display_name = each.value.display_name

  parent_management_group_id = (
    contains(keys(azurerm_management_group.level_2), each.value.parent_name)
    ? azurerm_management_group.level_2[each.value.parent_name].id
    : contains(keys(azurerm_management_group.level_1), each.value.parent_name)
    ? azurerm_management_group.level_1[each.value.parent_name].id
    : azurerm_management_group.level_0[each.value.parent_name].id
  )
}
