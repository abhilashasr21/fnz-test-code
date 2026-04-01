#****************************************************************#
#                        Management Group                        #
#****************************************************************#

module "management_group_parent" {
  source                     = "./Modules/Azure.Management"
  for_each                   = var.management_group
  display_name               = each.value.display_name
  parent_management_group_id = each.value.parent_management_group_id == null ? null : tostring(each.value.parent_management_group_id)
}

# module "management_group_child" {
#   source                     = "./Modules/Azure.Management"
#   display_name               = "FNZ_Child_001"
#   parent_management_group_id = module.management_group_parent.management_group_id
# }

#****************************************************************#
#                         Subscription                           #
#****************************************************************#



#****************************************************************#
#                            Budget                              #
#****************************************************************#



#****************************************************************#
#                   Subscription Association                     #
#****************************************************************#

# module "subscription_association" {
#   source              = "./Modules/Azure.Subscription_Association"
#   subscription_id     = "/subscriptions/f4a270f4-c469-4215-bef6-b4abaea6815e"
#   management_group_id = module.management_group_child.management_group_id
# }

#****************************************************************#
#                        Role Assignment                         #
#****************************************************************#