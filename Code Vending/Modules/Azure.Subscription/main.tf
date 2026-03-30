resource "azurerm_subscription" "subscription" {
  alias             = var.alias != null ? var.alias : "subscription"
  subscription_name = var.subscription_name
  billing_scope_id  = data.azurerm_billing_mca_account_scope.billing_details.id
  workload          = var.workload
}