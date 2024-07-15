resource "azurerm_virtual_network_gateway_connection" "name" {
  for_each = {
    for gateway_connection in var.gateway_connections :
    gateway_connection.name => gateway_connection
    if gateway_connection.name != null
  }

  name                = each.key
  resource_group_name = coalesce(each.value.resource_group_name, var.resource_group_name)
  location            = coalesce(each.value.location, var.location)
  type                = each.value.type
  virtual_network_gateway_id = startswith(each.value.virtual_network_gateway, "/subscriptions") ? (
    each.value.virtual_network_gateway
    ) : (
    azurerm_virtual_network_gateway.name[each.value.virtual_network_gateway].id
  )
  authorization_key               = each.value.authorization_key
  dpd_timeout_seconds             = each.value.dpd_timeout_seconds
  express_route_circuit_id        = each.value.express_route_circuit_id
  peer_virtual_network_gateway_id = each.value.peer_virtual_network_gateway_id
  local_azure_ip_address_enabled  = each.value.local_azure_ip_address_enabled
  local_network_gateway_id = startswith(each.value.local_network_gateway, "/subscriptions") ? (
    each.value.local_network_gateway
    ) : (
    azurerm_local_network_gateway.name[each.value.local_network_gateway].id
  )
  routing_weight      = each.value.routing_weight
  shared_key          = each.value.shared_key
  connection_mode     = each.value.connection_mode
  connection_protocol = each.value.connection_protocol
  enable_bgp          = each.value.enable_bgp

  dynamic "custom_bgp_addresses" {
    for_each = each.value.custom_bgp_addresses != null ? toset([each.value.custom_bgp_addresses]) : toset([])
    content {
      primary   = custom_bgp_addresses.value.primary
      secondary = custom_bgp_addresses.value.secondary
    }
  }

  express_route_gateway_bypass       = each.value.express_route_gateway_bypass
  private_link_fast_path_enabled     = each.value.private_link_fast_path_enabled
  egress_nat_rule_ids                = each.value.egress_nat_rule_ids
  ingress_nat_rule_ids               = each.value.ingress_nat_rule_ids
  use_policy_based_traffic_selectors = each.value.use_policy_based_traffic_selectors

  dynamic "ipsec_policy" {
    for_each = each.value.ipsec_policy != null ? toset([each.value.ipsec_policy]) : toset([])
    content {
      dh_group         = ipsec_policy.value.dh_group
      ike_encryption   = ipsec_policy.value.ike_encryption
      ike_integrity    = ipsec_policy.value.ike_integrity
      ipsec_encryption = ipsec_policy.value.ipsec_encryption
      ipsec_integrity  = ipsec_policy.value.ipsec_integrity
      pfs_group        = ipsec_policy.value.pfs_group
      sa_datasize      = ipsec_policy.value.sa_datasize
      sa_lifetime      = ipsec_policy.value.sa_lifetime
    }
  }

  dynamic "traffic_selector_policy" {
    for_each = each.value.traffic_selector_policy != null ? toset(each.value.traffic_selector_policy) : toset([])
    content {
      local_address_cidrs  = traffic_selector_policy.value.local_address_cidrs
      remote_address_cidrs = traffic_selector_policy.value.remote_address_cidrs
    }
  }

  tags = merge(var.tags, each.value.tags)
}
