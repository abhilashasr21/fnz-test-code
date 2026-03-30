variable "subscription_id" {
  description = "The Subscription ID in which the budget will be created."
  type        = string
}

variable "budget_name" {
  description = "The name of the budget."
  type        = string
}

variable "amount" {
  description = "The amount of the budget."
  type        = number
}

variable "time_grain" {
  description = "The time grain of the budget."
  type        = string
}

variable "start_date" {
  description = "The start date of the budget."
  type        = string
}

variable "end_date" {
  description = "The end date of the budget."
  type        = string
}