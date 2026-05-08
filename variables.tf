variable "location" {
  type    = string
  default = "ukwest"
}

variable "app_name" {
  type    = string
  default = "contso"
}

variable "vnet_address_range" {
  type    = set(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_address_range" {
  type    = list(string)
  default = ["10.0.2.0/24"]
}