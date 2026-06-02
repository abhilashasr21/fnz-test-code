variable "built_in_auth_strength_policies" {
  description = "A map of built-in authentication strength policies."
  type        = map(string)
  default     = {}
}
 
variable "built_in_role_definitions" {
  description = "A map of built-in role definitions."
  type        = map(string)
  default     = {}
}
 
variable "conditional_access_policies" {
  description = "A map of conditional access policies."
  type = map(object({
    display_name                                      = string
    state                                             = string
    include_groups                                    = optional(list(string))
    exclude_groups                                    = optional(list(string))
    include_users                                     = optional(list(string))
    exclude_users                                     = optional(list(string))
    include_roles                                     = optional(list(string))
    exclude_roles                                     = optional(list(string))
    include_guests_or_external_user_types             = optional(list(string))
    include_external_tenants_membership_kind          = optional(string)
    include_external_tenants_members                  = optional(list(string))
    exclude_guests_or_external_user_types             = optional(list(string))
    exclude_external_tenants_membership_kind          = optional(string)
    exclude_external_tenants_members                  = list(string)
    client_app_types                                  = list(string)
    sign_in_risk_levels                               = list(string)
    user_risk_levels                                  = list(string)
    service_principal_risk_levels                     = list(string)
    included_applications                             = list(string)
    excluded_applications                             = list(string)
    included_user_actions                             = list(string)
    included_locations                                = list(string)
    excluded_locations                                = list(string)
    included_platforms                                = list(string)
    excluded_platforms                                = list(string)
    device_filter_mode                                = optional(string)
    device_filter_rule                                = optional(string)
    grant_operator                                    = string
    grant_authentication_strength_policy              = optional(string)
    grant_built_in_controls                           = list(string)
    grant_custom_authentication_factors               = list(string)
    grant_terms_of_use                                = list(string)
    session_application_enforced_restrictions_enabled = optional(bool)
    session_cloud_app_security_policy                 = optional(string)
    session_disable_resilience_defaults               = optional(bool)
    session_persistent_browser_mode                   = optional(string)
    session_sign_in_frequency = optional(object({
      value               = optional(number)
      period              = optional(string)
      interval            = optional(string)
      authentication_type = optional(string)
    }))
  }))
  default = {}
}
 
variable "named_locations" {
  description = "A map of named locations."
  type = map(object({
    display_name                          = string
    is_country_location                   = bool
    countries_regions_list                = optional(list(string))
    country_lookup_method                 = optional(string)
    include_unknown_countries_and_regions = optional(bool)
    is_ip_location                        = bool
    ip_ranges                             = optional(list(string))
    is_trusted_ip_location                = optional(bool)
  }))
  default = {}
}
 
variable "auth_strength_policies" {
  description = "A map of authentication strength policies."
  type = map(object({
    display_name         = string
    description          = string
    allowed_combinations = list(string)
  }))
  default = {}
}
 
variable "tenant_id" {
  description = "The ID of the Entra ID tenant."
  type        = string
}