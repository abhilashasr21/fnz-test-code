# variable "management_groups" {
#   description = "Management groups to create"
#   type = map(object({
#     display_name = string
#     parent_id    = optional(string)
#   }))
#   # default = {}
# }

variable "display_name" {
  type = string
}

variable "parent_management_group_id" {
  type = string
  default = null
}