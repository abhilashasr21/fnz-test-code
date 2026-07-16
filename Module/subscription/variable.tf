variable "enrollment_account_id" {
  description = "Full ARM ID of the EA enrollment account"
  type        = string
  # e.g. /providers/Microsoft.Billing/billingAccounts/12345678/enrollmentAccounts/98765
}

variable "name" {
  description = "Alias — a stable name; can be reused to import an existing sub"
  type = string
}

variable "displayName" {
  description = "Friendly name shown in the portal"
  type = string
}

variable "workload" {
  description = "Production or DevTest"
  type = string
}

variable "managementGroupId" {
  description = "MG to place the sub under"
  type = string
}

variable "tags" {
  description = "Tags to be in suscription"
  type = map(string)
  default = {  }
}