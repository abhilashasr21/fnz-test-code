variable "display_name" {
  description = "The display name of the conditional access policy."
  type        = string
}
 
variable "state" {
  description = "The state of the conditional access policy. Possible values are 'enabled', 'disabled', and 'enabledForReportingButNotEnforced'."
  type        = string
  default     = "disabled"
  validation {
    condition     = contains(["enabled", "disabled", "enabledForReportingButNotEnforced"], var.state)
    error_message = "Invalid state. Valid values are 'enabled', 'disabled', and 'enabledForReportingButNotEnforced'."
  }
}
 
variable "include_groups" {
  description = "A list of group IDs to include in the policy."
  type        = list(string)
  default     = []
}
 
variable "exclude_groups" {
  description = "A list of group IDs to exclude from the policy."
  type        = list(string)
  default     = []
}
 
variable "include_users" {
  description = "A list of user IDs to include in the policy."
  type        = list(string)
  default     = []
}
 
variable "exclude_users" {
  description = "A list of user IDs to exclude from the policy."
  type        = list(string)
  default     = []
}
 
variable "include_roles" {
  description = "A list of role IDs to include in the policy."
  type        = list(string)
  default     = []
}
 
variable "exclude_roles" {
  description = "A list of role IDs to exclude from the policy."
  type        = list(string)
  default     = []
}
 
variable "include_guests_or_external_user_types" {
  description = "A list of guest or external user types to include in the policy."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.include_guests_or_external_user_types) == 0 || alltrue([for v in var.include_guests_or_external_user_types : contains(["b2bCollaborationGuest", "b2bCollaborationMember", "b2bDirectConnectUser", "internalGuest", "none", "otherExternalUser", "serviceProvider"], v)])
    error_message = "Invalid guest or external user type. Valid values are 'b2bCollaborationGuest', 'b2bCollaborationMember', 'b2bDirectConnectUser', 'internalGuest', 'none', 'otherExternalUser', and 'serviceProvider'."
  }
}
 
variable "include_external_tenants_membership_kind" {
  description = "The membership kind of external tenants to include in the policy."
  type        = string
  default     = null
  validation {
    condition     = var.include_external_tenants_membership_kind == null || contains(["all", "enumerated"], var.include_external_tenants_membership_kind)
    error_message = "Invalid external tenants membership kind. Valid values are 'all' and 'enumerated'."
  }
}
 
variable "include_external_tenants_members" {
  description = "A list of external tenant members to include in the policy."
  type        = list(string)
  default     = []
}
 
variable "exclude_guests_or_external_user_types" {
  description = "A list of guest or external user types to exclude from the policy."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.exclude_guests_or_external_user_types) == 0 || alltrue([for v in var.exclude_guests_or_external_user_types : contains(["b2bCollaborationGuest", "b2bCollaborationMember", "b2bDirectConnectUser", "internalGuest", "none", "otherExternalUser", "serviceProvider"], v)])
    error_message = "Invalid guest or external user type. Valid values are 'b2bCollaborationGuest', 'b2bCollaborationMember', 'b2bDirectConnectUser', 'internalGuest', 'none', 'otherExternalUser', and 'serviceProvider'."
  }
}
 
variable "exclude_external_tenants_membership_kind" {
  description = "The membership kind of external tenants to exclude from the policy."
  type        = string
  default     = null
  validation {
    condition     = var.exclude_external_tenants_membership_kind == null || contains(["all", "enumerated"], var.exclude_external_tenants_membership_kind)
    error_message = "Invalid external tenants membership kind. Valid values are 'all' and 'enumerated'."
  }
}
 
variable "exclude_external_tenants_members" {
  description = "A list of external tenant members to exclude from the policy."
  type        = list(string)
  default     = []
}
 
variable "client_app_types" {
  description = "A list of client app types to include in the policy."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.client_app_types) == 0 || alltrue([for v in var.client_app_types : contains(["all", "browser", "mobileAppsAndDesktopClients", "exchangeActiveSync", "easSupported", "other"], v)])
    error_message = "Invalid client app type. Valid values are 'all', 'browser', 'mobileAppsAndDesktopClients', 'exchangeActiveSync', 'easSupported', and 'other'."
  }
}
 
variable "sign_in_risk_levels" {
  description = "A list of sign-in risk levels to include in the policy."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.sign_in_risk_levels) == 0 || alltrue([for v in var.sign_in_risk_levels : contains(["low", "medium", "high", "none"], v)])
    error_message = "Invalid sign-in risk level. Valid values are 'low', 'medium', 'high', and 'none'."
  }
}
 
variable "user_risk_levels" {
  description = "A list of user risk levels to include in the policy."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.user_risk_levels) == 0 || alltrue([for v in var.user_risk_levels : contains(["low", "medium", "high", "none"], v)])
    error_message = "Invalid user risk level. Valid values are 'low', 'medium', 'high', and 'none'."
  }
}
 
variable "service_principal_risk_levels" {
  description = "A list of service principal risk levels to include in the policy."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.service_principal_risk_levels) == 0 || alltrue([for v in var.service_principal_risk_levels : contains(["low", "medium", "high", "none"], v)])
    error_message = "Invalid service principal risk level. Valid values are 'low', 'medium', 'high', and 'none'."
  }
}
 
variable "included_applications" {
  description = "A list of application IDs to include in the policy."
  type        = list(string)
  default     = []
}
 
variable "excluded_applications" {
  description = "A list of application IDs to exclude from the policy."
  type        = list(string)
  default     = []
}
 
variable "included_user_actions" {
  description = "A list of user actions to include in the policy."
  type        = list(string)
  default     = []
}
 
variable "included_locations" {
  description = "A list of locations to include in the policy."
  type        = list(string)
  default     = []
}
 
variable "excluded_locations" {
  description = "A list of locations to exclude from the policy."
  type        = list(string)
  default     = []
}
 
variable "included_platforms" {
  description = "A list of platforms to include in the policy."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.included_platforms) == 0 || alltrue([for v in var.included_platforms : contains(["all", "android", "iOS", "windows", "macOS", "linux"], v)])
    error_message = "Invalid platform. Valid values are 'all', 'android', 'iOS', 'windows', 'macOS', and 'linux'."
  }
}
 
variable "excluded_platforms" {
  description = "A list of platforms to exclude from the policy."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.excluded_platforms) == 0 || alltrue([for v in var.excluded_platforms : contains(["all", "android", "iOS", "windows", "macOS", "linux"], v)])
    error_message = "Invalid platform. Valid values are 'all', 'android', 'iOS', 'windows', 'macOS', and 'linux'."
  }
}
 
variable "device_filter_mode" {
  description = ""
  type        = string
  default     = null
  validation {
    condition     = var.device_filter_mode == null || contains(["include", "exclude"], var.device_filter_mode)
    error_message = "Invalid device filter mode. Valid values are 'include', and 'exclude'."
  }
}
 
variable "device_filter_rule" {
  description = "The rule to apply for device filtering. This should be a valid filter expression based on the Microsoft Graph API documentation for device filters."
  type        = string
  default     = null
}
 
variable "grant_operator" {
  description = "The operator to use for grant controls. Valid values are 'AND' and 'OR'."
  type        = string
  validation {
    condition     = var.grant_operator == null || contains(["AND", "OR"], var.grant_operator)
    error_message = "Invalid grant operator. Valid values are 'AND' and 'OR'."
  }
}
 
variable "grant_built_in_controls" {
  description = "A list of built-in controls to include in the policy."
  type        = list(string)
  default     = []
  validation {
    condition     = length(var.grant_built_in_controls) == 0 || alltrue([for v in var.grant_built_in_controls : contains(["block", "mfa", "approvedApplication", "compliantApplication", "compliantDevice", "domainJoinedDevice", "passwordChange"], v)])
    error_message = "Invalid built-in control. Valid values are 'block', 'mfa', 'approvedApplication', 'compliantApplication', 'compliantDevice', 'domainJoinedDevice', and 'passwordChange'."
  }
}
 
variable "grant_custom_authentication_factors" {
  description = "A list of custom authentication factors (id's) to include in the policy."
  type        = list(string)
  default     = []
}
 
variable "grant_authentication_strength_policy_id" {
  description = "The ID of the authentication strength policy to include in the policy."
  type        = string
  default     = null
}
 
variable "grant_terms_of_use" {
  description = "A list of terms of use IDs to include in the policy."
  type        = list(string)
  default     = []
}
 
variable "session_application_enforced_restrictions_enabled" {
  description = "Whether application enforced restrictions are enabled for the session."
  type        = bool
  default     = null
}
 
variable "session_cloud_app_security_policy" {
  description = "The cloud app security policy to apply to the session."
  type        = string
  default     = null
  validation {
    condition     = var.session_cloud_app_security_policy == null || contains(["blockDownloads", "mcasConfigured", "monitorOnly"], var.session_cloud_app_security_policy)
    error_message = "Invalid cloud app security policy. Valid values are 'blockDownloads', 'mcasConfigured', and 'monitorOnly'."
  }
}
 
variable "session_disable_resilience_defaults" {
  description = "Whether to disable resilience defaults for the session."
  type        = bool
  default     = null
}
 
variable "session_persistent_browser_mode" {
  description = "The persistent browser mode to apply to the session."
  type        = string
  default     = null
}
 
variable "session_sign_in_frequency" {
  description = "The sign-in frequency to apply to the session. This should be an object with the following properties: value (int), period (string), interval (string), and authentication_type (string). The period property should be one of 'hour', 'day', 'week', or 'month'. The authentication_type property should be one of 'primaryAndSecondaryAuthentication', 'secondaryAuthentication', or 'primaryAuthentication'."
  type = object({
    value               = optional(number)
    period              = optional(string)
    interval            = optional(string)
    authentication_type = optional(string)
  })
  default = null
}