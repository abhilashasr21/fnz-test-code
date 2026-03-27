module "management_group" {
  source = "./Modules/Azure.Management"
  management_groups = {
    management_group_parent = {
      display_name = "FNZ Parent Group"
      parent_id    = null
    },
    child_management_group1 = {
      display_name = "FNZ Child Group 1"
      parent_id    = "ae2b7911-aa3a-4b25-b745-df89a279957a"
    }
  }
}