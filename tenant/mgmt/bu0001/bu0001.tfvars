# 

child_management_groups = {
  mg111 = { name = "mg111", display_name = "Terraform Child 3 Management Group", parent_id = "mg201" }
  mg112 = { name = "mg112", display_name = "Terraform Child 2 Management Group", parent_id = "mg201" }
  mg201 = { name = "mg201", display_name = "Terraform Parent Management Group", parent_id = "48d31bc6-3359-4e9d-af8b-75b9b41ebd66" }
  mg202 = { name = "mg202", display_name = "Terraform Child Management Group", parent_id = "mg201" }
  mg301 = { name = "mg301", display_name = "Child 301", parent_id = "48d31bc6-3359-4e9d-af8b-75b9b41ebd66" }
  mg311 = { name = "mg311", display_name = "Child 311", parent_id = "mg301" }
  mg321 = { name = "mg321", display_name = "Child 321", parent_id = "mg301" }
  mg322 = { name = "mg322", display_name = "Child 322", parent_id = "mg301" }
  mg401 = { name = "mg401", display_name = "Child 401", parent_id = "mg202" }
  mg402 = { name = "mg402", display_name = "Child 402", parent_id = "mg202" }
  mg403 = { name = "mg403", display_name = "Child 403", parent_id = "mg202" }
}