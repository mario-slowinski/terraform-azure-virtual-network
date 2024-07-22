resource "azurerm_virtual_network_gateway_nat_rule" "name" {
  for_each = {
    for gateway_nat_rule in var.gateway_nat_rules :
    gateway_nat_rule.name => gateway_nat_rule
    if gateway_nat_rule.name != null
  }

  name = each.key
  resource_group_name = coalesce(
    each.value.resource_group_name,
    azurerm_virtual_network_gateway.name[each.value.virtual_network_gateway].resource_group_name
  )
  virtual_network_gateway_id = startswith(each.value.virtual_network_gateway, "/subscriptions") ? (
    each.value.virtual_network_gateway
    ) : (
    azurerm_virtual_network_gateway.name[each.value.virtual_network_gateway].id
  )
  mode = each.value.mode
  type = each.value.type

  dynamic "external_mapping" {
    for_each = each.value.external_mappings != null ? toset(each.value.external_mappings) : toset([])
    content {
      address_space = external_mapping.value.address_space
      port_range    = external_mapping.value.port_range
    }
  }

  dynamic "internal_mapping" {
    for_each = each.value.internal_mappings != null ? toset(each.value.internal_mappings) : toset([])
    content {
      address_space = internal_mapping.value.address_space
      port_range    = internal_mapping.value.port_range
    }
  }
}
