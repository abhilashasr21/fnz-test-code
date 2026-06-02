## resolution of auth strength policies and named locations from variable object names to ids for use in conditional access policies
 
## Auth strength Policy ID resolution:
locals {
  custom_auth_strength_policy_ids = {
    for k, m in module.auth_strength_policy :
    k => m.auth_strength_id
  }
}
 
locals {
  all_auth_strength_policy_ids = merge(
    var.built_in_auth_strength_policies,
    local.custom_auth_strength_policy_ids
  )
}
 
locals {
  ca_auth_strength_policy_ids = {
    for k, v in var.conditional_access_policies :
    k => (
      try(v.grant_authentication_strength_policy, null) != null
      ? lookup(local.all_auth_strength_policy_ids, v.grant_authentication_strength_policy, null)
      : null
    )
  }
}
 
## Named Location ID resolution:
locals {
  named_location_ids = {
    for k, v in module.named_location :
    k => v.named_location_id
  }
}
 
locals {
  ca_named_location_ids = {
    for k, v in var.conditional_access_policies :
    k => {
      included = [
        for loc in v.included_locations :
        local.named_location_ids[loc]
      ]
      excluded = [
        for loc in v.excluded_locations :
        local.named_location_ids[loc]
      ]
    }
  }
}
 
## group name lookup for conditional access policies that reference groups by name
## collect all group names from conditional access policies.
locals {
  all_group_names = toset(compact(distinct(flatten([
    for policy in values(var.conditional_access_policies) : concat(
      try(policy.include_groups, []),
      try(policy.exclude_groups, [])
    )
  ]))))
}
 
## lookup group ids fior all unique group names used in conditional access policies
data "azuread_groups" "ca_policy_groups" {
  display_names = tolist(local.all_group_names)
}
 
## create a map of group name to group id for use in conditional access policies
locals {
  group_name_to_id = zipmap(
    data.azuread_groups.ca_policy_groups.display_names,
    data.azuread_groups.ca_policy_groups.object_ids
  )
}
 
locals {
  policy_group_ids = {
    for policyname, policy in var.conditional_access_policies : policyname => {
      included_groups = (
        length(try(policy.include_groups, [])) == 0 ? null :
        [for group in try(policy.include_groups, []) : local.group_name_to_id[group]]
      )
      excluded_groups = (
        length(try(policy.exclude_groups, [])) == 0 ? null :
        [for group in try(policy.exclude_groups, []) : local.group_name_to_id[group]]
      )
    }
  }
}
 
## role name lookup for conditional access policies that reference roles by name
locals {
  policy_role_ids = {
    for policyname, policy in var.conditional_access_policies : policyname => {
      included_roles = [
        for role in coalesce(policy.include_roles, []) : var.built_in_role_definitions[role]
      ]
      excluded_roles = [
        for role in coalesce(policy.exclude_roles, []) : var.built_in_role_definitions[role]
      ]
    }
  }
}