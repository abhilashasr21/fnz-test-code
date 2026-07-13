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

# resource "azapi_resource" "management_group_child2" {
#   type      = "Microsoft.Management/managementGroups@2021-04-01"
#   name      = "mg112"
#   parent_id = "/"

#   body = {
#     properties = {
#       displayName = "Terraform Child 2 Management Group"
#       details = {
#         parent = {
#           id = azapi_resource.management_group_parent.id
#         }
#       }
#     }
#   }
# }