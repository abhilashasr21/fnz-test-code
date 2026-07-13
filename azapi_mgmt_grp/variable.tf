variable "child_management_groups" {
  type = map(object({
    name         = string
    display_name = string
  }))
}