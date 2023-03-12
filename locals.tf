locals {
  zip = zipmap(var.tags_keys, var.tags_values)

  # must be as separated lists because maps are automatically sorted
  tags = [
    for key, value in local.zip : {
      key   = key
      value = value
    } if value != ""
  ]

  names = compact(matchkeys(var.tags_values, var.tags_keys, var.names_keys))

  name = replace(join(var.separator, local.names), " ", var.space)
}
