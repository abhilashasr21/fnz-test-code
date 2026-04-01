variable "management_group" {
  type = map(object({
    display_name               = string
    parent_management_group_id = optional(string)
  }))
}