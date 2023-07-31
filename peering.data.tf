data "azurerm_virtual_network" "remote" {
  for_each = {
    for peering in var.peerings :
    coalesce(peering.local.name, peering.remote.virtual_network_name) => peering
    if peering.remote.virtual_network_name != null
  }

  name                = each.value.remote.virtual_network_name
  resource_group_name = each.value.remote.resource_group_name
}
