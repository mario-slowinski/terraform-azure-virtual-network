resource "azurerm_virtual_network_peering" "remote" {
  for_each = {
    for peering in var.peerings :
    coalesce(peering.remote.name, local.name) => peering
    if peering.remote.virtual_network_name != null
  }

  name                         = each.key
  virtual_network_name         = each.value.remote.virtual_network_name
  remote_virtual_network_id    = azurerm_virtual_network.this.id
  resource_group_name          = each.value.remote.resource_group_name
  allow_virtual_network_access = each.value.remote.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.remote.allow_forwarded_traffic
  allow_gateway_transit        = each.value.remote.allow_gateway_transit
  use_remote_gateways          = each.value.remote.use_remote_gateways
  triggers                     = each.value.remote.triggers
}

resource "azurerm_virtual_network_peering" "local" {
  for_each = {
    for peering in var.peerings :
    try(peering.local.name, peering.remote.virtual_network_name) => peering
    if peering.remote.virtual_network_name != null
  }

  name                         = each.key
  virtual_network_name         = azurerm_virtual_network.this.name
  remote_virtual_network_id    = data.azurerm_virtual_network.remote[each.key].id
  resource_group_name          = try(each.value.local.resource_group_name, var.resource_group_name)
  allow_virtual_network_access = try(each.value.local.allow_virtual_network_access, null)
  allow_forwarded_traffic      = try(each.value.local.allow_forwarded_traffic, null)
  allow_gateway_transit        = try(each.value.local.allow_gateway_transit, null)
  use_remote_gateways          = try(each.value.local.use_remote_gateways, null)
  triggers                     = try(each.value.local.triggers, null)
}
