variable "alias" {
  type        = string
  description = "Alias name for the subscription resource. If not provided, defaults to 'subscription'."
  default     = null
}

variable "subscription_name" {
  type        = string
  description = "Name of the subscription resource."
}

variable "billing_account_name" {
  type        = string
  description = "Name of the billing account."
}

variable "billing_profile_name" {
  type        = string
  description = "Name of the billing profile."
}

variable "invoice_section_name" {
  type        = string
  description = "Name of the invoice section."
}

variable "workload" {
  type        = string
  description = "Workload type for the subscription resource."
}