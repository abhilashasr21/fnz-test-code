resource "azapi_resource" "management_group_parent" {
  type      = "Microsoft.Management/managementGroups@2021-04-01"
  name      = "mg201"
  parent_id = "/"  

  body = {
    properties = {
      displayName = "Terraform Parent Management Group"
    }
  }
}

resource "azurerm_management_group" "management_group_child" {
  display_name = "Terraform Child Management Group"
  parent_management_group_id = azapi_resource.management_group_parent.id
}