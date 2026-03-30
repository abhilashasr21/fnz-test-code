resource "azurerm_consumption_budget_subscription" "budget" {
  name            = var.budget_name
  subscription_id = data.azurerm_subscription.subscription.id

  amount     = var.amount
  time_grain = var.time_grain

  time_period {
    start_date = var.start_date
    end_date   = var.end_date
  }

  filter {
    # dimension {
    #   name = "ResourceGroupName"
    #   values = [
    #     azurerm_resource_group.example.name,
    #   ]
    # }
  }

  notification {
    # enabled   = true
    threshold = 90.0
    operator  = "EqualTo"

    # contact_emails = [
    #   "foo@example.com",
    #   "bar@example.com",
    # ]

    # contact_groups = [
    #   azurerm_monitor_action_group.example.id,
    # ]

    # contact_roles = [
    #   "Owner",
    # ]
  }

  notification {
    # enabled        = false
    threshold = 100.0
    operator  = "GreaterThan"
    # threshold_type = "Forecasted"

    # contact_emails = [
    #   "foo@example.com",
    #   "bar@example.com",
    # ]
  }
}