resource "azurerm_virtual_network_gateway" "name" {
  for_each = {
    for name in [var.gateway] :
    name => var.gateway
    if name != null
  }

  active_active = each.value.active_active

  dynamic "bgp_settings" {
    for_each = each.value.bgp_settings != null ? toset([each.value.bgp_settings]) : toset([])
    content {
      asn = bgp_settings.value.asn

      dynamic "peering_addresses" {
        for_each = {
          for peering_address in bgp_settings.value.peering_addresses :
          peering_address.ip_configuration_name => peering_address
          if peering_address.ip_configuration_name != null
        }
        content {
          ip_configuration_name = peering_addresses.value.ip_configuration_name
          apipa_addresses       = peering_addresses.value.apipa_addresses
        }
      }

      peer_weight = bgp_settings.value.peer_weight
    }
  }

  dynamic "custom_route" {
    for_each = each.value.custom_route != null ? toset([each.value.custom_route]) : toset([])
    content {
      address_prefixes = custom_route.value.address_prefixes
    }
  }

  default_local_network_gateway_id = each.value.default_local_network_gateway_id
  edge_zone                        = each.value.edge_zone
  enable_bgp                       = each.value.enable_bgp
  generation                       = each.value.generation

  dynamic "ip_configuration" {
    for_each = {
      for ip_configuration in each.value.ip_configurations :
      ip_configuration.subnet_id => ip_configuration
      if ip_configuration.subnet_id != null
    }
    content {
      name                          = ip_configurations.value.name
      private_ip_address_allocation = ip_configurations.value.private_ip_address_allocation
      subnet_id                     = ip_configurations.value.subnet_id
      public_ip_address_id          = ip_configurations.value.public_ip_address_id
    }
  }

  location                   = coalesce(each.value.location, var.location)
  name                       = each.value.name
  private_ip_address_enabled = each.value.private_ip_address_enabled
  resource_group_name        = each.value.resource_group_name
  sku                        = each.value.sku
  type                       = each.value.type
  vpn_type                   = each.value.vpn_type

  dynamic "vpn_client_configuration" {
    for_each = each.value.vpn_client_configuration != null ? toset([each.value.vpn_client_configuration]) : toset([])
    content {
      address_space = vpn_client_configuration.value.address_space
      aad_tenant    = vpn_client_configuration.value.aad_tenant
      aad_audience  = vpn_client_configuration.value.aad_audience
      aad_issuer    = vpn_client_configuration.value.aad_issuer

      dynamic "root_certificate" {
        for_each = {
          for root_certificate in vpn_client_configuration.value.root_certificates :
          root_certificate.name => root_certificate
          if root_certificate.name != null
        }
        content {
          name             = root_certificate.value.name
          public_cert_data = root_certificate.value.public_cert_data
        }
      }

      dynamic "revoked_certificate" {
        for_each = {
          for revoked_certificate in vpn_client_configuration.value.revoked_certificates :
          revoked_certificate.name => revoked_certificate
          if revoked_certificate.name != null
        }
        content {
          name             = root_certificate.value.name
          public_cert_data = root_certificate.value.public_cert_data
        }
      }

      radius_server_address = vpn_client_configuration.value.radius_server_address
      radius_server_secret  = vpn_client_configuration.value.radius_server_secret
      vpn_client_protocols  = vpn_client_configuration.value.vpn_client_protocols
      vpn_auth_types        = vpn_client_configuration.value.vpn_auth_types
    }
  }

  tags = merge(local.tags, var.tags, each.value.gateway.tags)
}
