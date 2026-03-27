variable "management_groups" {
  description = "Management groups to create"
  type = map(object({
    display_name = string
    parent_id    = optional(string)
  }))
  default = {}
}

# variable "display_name" {
#   description = "Display name for the management group"
#   type        = string
# }

# variable "parent_id" {
#   description = "ID of the parent management group (optional)"
#   type        = string
#   default     = null  
# }