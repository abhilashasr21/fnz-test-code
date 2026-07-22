# variable "location" {
#   type    = string
#   default = "ukwest"
# }

# variable "app_name" {
#   type    = string
#   default = "contso"
# }

# variable "vnet_address_range" {
#   type    = set(string)
#   default = ["10.0.0.0/16"]
# }

# variable "subnet_address_range" {
#   type    = list(string)
#   default = ["10.0.2.0/24"]
# }

variable "management_groups" {
  type = map(object({
    name         = string
    display_name = string
    parent_id    = optional(string)
  }))
  default = {}
}

variable "subscription_name" {
  type = string
  default = "Visual Studio Enterprise Subscription"
}

variable "subscription_display_name" {
  type = string
  default = "Visual Studio Enterprise Subscription"
}

variable "subscription_workload" {
  type = string
  default = "Production"
}

variable "enrollment_account_id" {
  type = string
}

variable "management_group_id" {
  type = string
}

variable "workload" {
  type = string
  default = "Production"
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "resource_providers" {
  type = list(string)
  default = []
}