resource "azurerm_virtual_network_peering" "name" {
  for_each = {
    for peering in var.peerings :
    peering.name => peering
    if peering.name != null
  }

  name                         = coalesce(each.value.name, var.name, local.name)
  virtual_network_name         = azurerm_virtual_network.this.name
  remote_virtual_network_id    = each.value.remote_virtual_network_id
  resource_group_name          = coalesce(each.value.resource_group_name, var.resource_group_name, local.name)
  allow_virtual_network_access = each.value.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  allow_gateway_transit        = each.value.allow_gateway_transit
  use_remote_gateways          = each.value.use_remote_gateways
  triggers                     = each.value.triggers
}
