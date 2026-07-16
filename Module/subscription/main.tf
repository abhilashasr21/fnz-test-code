resource "azapi_resource" "this" {
  type      = "Microsoft.Subscription/aliases@2021-10-01"
  name      = var.name#"sub-prod-workload-001"       # Alias name (must be unique in tenant)
  parent_id = "/"

  body = {
    properties = {
      displayName  = var.displayName
      workload     = var.workload          # or "DevTest"
      billingScope = var.enrollment_account_id
      additionalProperties = {
        managementGroupId = var.managementGroupId
        tags = var.tags
      }
    }
  }

  response_export_values = ["properties.subscriptionId"]
}

output "subscription_id" {
  value = azapi_resource.this.output.properties.subscriptionId
}