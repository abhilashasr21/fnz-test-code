resource "azapi_resource" "this" {
  type      = "Microsoft.Subscription/aliases@2021-10-01"
  name      = var.name
  parent_id = "/"

  body = {
    properties = {
      displayName  = var.displayName
      workload     = var.workload
      billingScope = var.enrollment_account_id
      additionalProperties = {
        managementGroupId = var.managementGroupId
        tags              = var.tags
      }
    }
  }

  response_export_values = ["properties.subscriptionId"]
}

locals {
  subscription_id = azapi_resource.this.output.properties.subscriptionId
}

# Register each resource provider on the newly created subscription
resource "azapi_resource_action" "register_providers" {
  for_each = toset(var.resource_providers)

  type        = "Microsoft.Resources/providers@2022-12-01"
  resource_id = "/subscriptions/${local.subscription_id}/providers/${each.value}"
  action      = "register"
  method      = "POST"

  # Ensure the subscription exists first
  depends_on = [azapi_resource.this]
}

output "subscription_id" {
  value = local.subscription_id
}

output "registered_providers" {
  value = var.resource_providers
}