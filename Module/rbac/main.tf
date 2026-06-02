resource "azuread_conditional_access_policy" "cap_module" {
 
  display_name = var.display_name
  state        = var.state
 
  conditions {
    users {
      included_groups = ((var.include_groups != null) && length(var.include_groups) > 0) ? var.include_groups : null
      excluded_groups = ((var.exclude_groups != null) && length(var.exclude_groups) > 0) ? var.exclude_groups : null
 
      included_users = ((var.include_users != null) && length(var.include_users) > 0) ? var.include_users : null
      excluded_users = ((var.exclude_users != null) && length(var.exclude_users) > 0) ? var.exclude_users : null
 
      included_roles = ((var.include_roles != null) && length(var.include_roles) > 0) ? var.include_roles : null
      excluded_roles = ((var.exclude_roles != null) && length(var.exclude_roles) > 0) ? var.exclude_roles : null
 
      dynamic "included_guests_or_external_users" {
        for_each = (length(var.include_guests_or_external_user_types) > 0) || (var.include_external_tenants_membership_kind != null) ? [1] : []
        content {
          guest_or_external_user_types = length(var.include_guests_or_external_user_types) > 0 ? var.include_guests_or_external_user_types : null
 
          dynamic "external_tenants" {
            for_each = var.include_external_tenants_membership_kind != null ? [1] : []
            content {
              membership_kind = var.include_external_tenants_membership_kind
              members         = (var.include_external_tenants_membership_kind == "enumerated" && length(var.include_external_tenants_members) > 0) ? var.include_external_tenants_members : null
            }
          }
        }
      }
 
      dynamic "excluded_guests_or_external_users" {
        for_each = (length(var.exclude_guests_or_external_user_types) > 0) || (var.exclude_external_tenants_membership_kind != null) ? [1] : []
        content {
          guest_or_external_user_types = length(var.exclude_guests_or_external_user_types) > 0 ? var.exclude_guests_or_external_user_types : null
 
          dynamic "external_tenants" {
            for_each = var.exclude_external_tenants_membership_kind != null ? [1] : []
            content {
              membership_kind = var.exclude_external_tenants_membership_kind
              members         = (var.exclude_external_tenants_membership_kind == "enumerated" && length(var.exclude_external_tenants_members) > 0) ? var.exclude_external_tenants_members : null
            }
          }
        }
      }
    }
 
    client_app_types              = ((var.client_app_types != null) && length(var.client_app_types) > 0) ? var.client_app_types : null
    sign_in_risk_levels           = ((var.sign_in_risk_levels != null) && length(var.sign_in_risk_levels) > 0) ? var.sign_in_risk_levels : null
    user_risk_levels              = ((var.user_risk_levels != null) && length(var.user_risk_levels) > 0) ? var.user_risk_levels : null
    service_principal_risk_levels = ((var.service_principal_risk_levels != null) && length(var.service_principal_risk_levels) > 0) ? var.service_principal_risk_levels : null
 
    applications {
      included_applications = ((var.included_applications != null) && length(var.included_applications) > 0) ? var.included_applications : null
      excluded_applications = ((var.excluded_applications != null) && length(var.excluded_applications) > 0) ? var.excluded_applications : null
      included_user_actions = ((var.included_user_actions != null) && length(var.included_user_actions) > 0) ? var.included_user_actions : null
    }
 
    dynamic "locations" {
      for_each = (
        ((var.included_locations != null) && length(var.included_locations) > 0) || ((var.excluded_locations != null) && length(var.excluded_locations) > 0)
      ) ? [1] : []
      content {
        included_locations = length(var.included_locations) > 0 ? var.included_locations : []
        excluded_locations = length(var.excluded_locations) > 0 ? var.excluded_locations : []
      }
    }
 
    dynamic "platforms" {
      for_each = (
        ((var.included_platforms != null) && length(var.included_platforms) > 0) || ((var.excluded_platforms != null) && length(var.excluded_platforms) > 0)
      ) ? [1] : []
      content {
        included_platforms = length(var.included_platforms) > 0 ? var.included_platforms : []
        excluded_platforms = length(var.excluded_platforms) > 0 ? var.excluded_platforms : []
      }
    }
 
    dynamic "devices" {
      for_each = var.device_filter_mode != null && var.device_filter_rule != null ? [1] : []
      content {
        filter {
          mode = var.device_filter_mode
          rule = var.device_filter_rule
        }
      }
    }
  }
 
  grant_controls {
    operator                          = var.grant_operator
    authentication_strength_policy_id = (var.grant_authentication_strength_policy_id != null) ? var.grant_authentication_strength_policy_id : null
    built_in_controls                 = ((var.grant_built_in_controls != null) && length(var.grant_built_in_controls) > 0) ? var.grant_built_in_controls : null
    custom_authentication_factors     = ((var.grant_custom_authentication_factors != null) && length(var.grant_custom_authentication_factors) > 0) ? var.grant_custom_authentication_factors : null
    terms_of_use                      = ((var.grant_terms_of_use != null) && length(var.grant_terms_of_use) > 0) ? var.grant_terms_of_use : null
  }
 
  dynamic "session_controls" {
    for_each = [true] # always emit the block, but only set attributes that are non-null
    content {
      application_enforced_restrictions_enabled = var.session_application_enforced_restrictions_enabled
      cloud_app_security_policy                 = var.session_cloud_app_security_policy
      disable_resilience_defaults               = var.session_disable_resilience_defaults
      persistent_browser_mode                   = var.session_persistent_browser_mode
      sign_in_frequency                         = (var.session_sign_in_frequency != null && try(var.session_sign_in_frequency.value, null) != null) ? var.session_sign_in_frequency.value : null
      sign_in_frequency_period                  = (var.session_sign_in_frequency != null && try(var.session_sign_in_frequency.period, null) != null) ? var.session_sign_in_frequency.period : null
      sign_in_frequency_interval                = (var.session_sign_in_frequency != null && try(var.session_sign_in_frequency.interval, null) != null) ? var.session_sign_in_frequency.interval : null
      sign_in_frequency_authentication_type     = (var.session_sign_in_frequency != null && try(var.session_sign_in_frequency.authentication_type, null) != null) ? var.session_sign_in_frequency.authentication_type : null
    }
  }
}
 