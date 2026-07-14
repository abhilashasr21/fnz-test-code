# resource "azapi_resource" "management_group_parent" {
#   type      = "Microsoft.Management/managementGroups@2021-04-01"
#   name      = "mg201"
#   parent_id = "/"

#   body = {
#     properties = {
#       displayName = "Terraform Parent Management Group"
#     }
#   }
# }

# resource "azapi_resource" "management_group_child" {
#   type      = "Microsoft.Management/managementGroups@2021-04-01"
#   name      = "mg202"
#   parent_id = "/"

#   body = {
#     properties = {
#       displayName = "Terraform Child Management Group"
#       details = {
#         parent = {
#           id = azapi_resource.management_group_parent.id
#         }
#       }
#     }
#   }
# }
resource "azapi_resource" "management_group_child2" {
  for_each = var.child_management_groups

  type      = "Microsoft.Management/managementGroups@2021-04-01"
  name      = each.value.name
  parent_id = "/"

  body = {
    properties = {
      displayName = each.value.display_name
      details = {
        parent = {
          id = each.value.parent_id != null ? ("/providers/Microsoft.Management/managementGroups/${each.value.parent_id}") : azapi_resource.management_group_parent.id
        }
      }
    }
  }
}