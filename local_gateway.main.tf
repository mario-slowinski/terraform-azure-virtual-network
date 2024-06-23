resource "azurerm_local_network_gateway" "name" {
  for_each = {
    for local_network_gateway in var.local_network_gateways :
    local_network_gateway.name => local_network_gateway
    if local_network_gateway.name != null
  }

  name                = each.value.name
  resource_group_name = coalesce(each.value.resource_group_name, var.resource_group_name)
  location            = coalesce(each.value.location, var.location)
  address_space       = each.value.address_space

  dynamic "bgp_settings" {
    for_each = each.value.bgp_settings != null ? toset([each.value.bgp_settings]) : toset([])
    content {
      asn                 = bgp_settings.value.asn
      bgp_peering_address = bgp_settings.value.bgp_peering_address
      peer_weight         = bgp_settings.value.peer_weight
    }
  }

  gateway_address = each.value.gateway_address
  gateway_fqdn    = each.value.gateway_fqdn
  tags            = merge(var.tags, each.value.tags)
}
