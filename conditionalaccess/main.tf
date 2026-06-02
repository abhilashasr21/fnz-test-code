## CA policy module
module "ca_policy" {
  for_each                                          = var.conditional_access_policies
  source                                            = "../modules/conditional-access-policies"
  display_name                                      = each.value.display_name
  state                                             = each.value.state
  include_users                                     = each.value.include_users
  exclude_users                                     = each.value.exclude_users
  include_groups                                    = local.policy_group_ids[each.key].included_groups
  exclude_groups                                    = local.policy_group_ids[each.key].excluded_groups
  include_roles                                     = local.policy_role_ids[each.key].included_roles
  exclude_roles                                     = local.policy_role_ids[each.key].excluded_roles
  include_guests_or_external_user_types             = each.value.include_guests_or_external_user_types
  include_external_tenants_membership_kind          = each.value.include_external_tenants_membership_kind
  include_external_tenants_members                  = each.value.include_external_tenants_members
  exclude_guests_or_external_user_types             = each.value.exclude_guests_or_external_user_types
  exclude_external_tenants_membership_kind          = each.value.exclude_external_tenants_membership_kind
  exclude_external_tenants_members                  = each.value.exclude_external_tenants_members
  client_app_types                                  = each.value.client_app_types
  sign_in_risk_levels                               = each.value.sign_in_risk_levels
  user_risk_levels                                  = each.value.user_risk_levels
  service_principal_risk_levels                     = each.value.service_principal_risk_levels
  included_applications                             = each.value.included_applications
  excluded_applications                             = each.value.excluded_applications
  included_user_actions                             = each.value.included_user_actions
  included_locations                                = local.ca_named_location_ids[each.key].included
  excluded_locations                                = local.ca_named_location_ids[each.key].excluded
  included_platforms                                = each.value.included_platforms
  excluded_platforms                                = each.value.excluded_platforms
  device_filter_mode                                = each.value.device_filter_mode
  device_filter_rule                                = each.value.device_filter_rule
  grant_operator                                    = each.value.grant_operator
  grant_authentication_strength_policy_id           = (local.ca_auth_strength_policy_ids[each.key] != null) ? "/policies/authenticationStrengthPolicies/${local.ca_auth_strength_policy_ids[each.key]}" : null
  grant_built_in_controls                           = each.value.grant_built_in_controls
  grant_custom_authentication_factors               = each.value.grant_custom_authentication_factors
  session_application_enforced_restrictions_enabled = each.value.session_application_enforced_restrictions_enabled
  session_cloud_app_security_policy                 = each.value.session_cloud_app_security_policy
  session_disable_resilience_defaults               = each.value.session_disable_resilience_defaults
  session_persistent_browser_mode                   = each.value.session_persistent_browser_mode
  session_sign_in_frequency                         = each.value.session_sign_in_frequency
}
 
## Named Location module
module "named_location" {
  for_each                              = var.named_locations
  source                                = "../modules/named-location"
  display_name                          = each.value.display_name
  is_country_location                   = each.value.is_country_location
  countries_regions_list                = each.value.countries_regions_list
  country_lookup_method                 = each.value.country_lookup_method
  include_unknown_countries_and_regions = each.value.include_unknown_countries_and_regions
  is_ip_location                        = each.value.is_ip_location
  ip_ranges                             = each.value.ip_ranges
  is_trusted_ip_location                = each.value.is_trusted_ip_location
}
 
## Custom Auth Strength Policy module
module "auth_strength_policy" {
  for_each             = var.auth_strength_policies
  source               = "../modules/custom-auth-strengths"
  display_name         = each.value.display_name
  description          = each.value.description
  allowed_combinations = each.value.allowed_combinations
}