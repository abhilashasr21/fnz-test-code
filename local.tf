locals {
  mg_data = jsondecode(file("${path.module}/management-structure.json"))

  level_0 = [
    for mg in local.mg_data.management_groups : {
      name         = mg.name
      display_name = mg.display_name
      parent_name  = null
    }
  ]

  level_1 = flatten([
    for parent in local.mg_data.management_groups : [
      for child in lookup(parent, "children", []) : {
        name         = child.name
        display_name = child.display_name
        parent_name  = parent.name
      }
    ]
  ])

  level_2 = flatten([
    for parent in local.mg_data.management_groups : [
      for child in lookup(parent, "children", []) : [
        for grandchild in lookup(child, "children", []) : {
          name         = grandchild.name
          display_name = grandchild.display_name
          parent_name  = child.name
        }
      ]
    ]
  ])

  level_3 = flatten([
    for parent in local.mg_data.management_groups : [
      for child in lookup(parent, "children", []) : [
        for grandchild in lookup(child, "children", []) : [
          for great_grandchild in lookup(grandchild, "children", []) : {
            name         = great_grandchild.name
            display_name = great_grandchild.display_name
            parent_name  = grandchild.name
          }
        ]
      ]
    ]
  ])
}