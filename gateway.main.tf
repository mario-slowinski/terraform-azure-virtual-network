resource "azurerm_virtual_network_gateway" "name" {
  for_each = {
    for name in [var.gateway.name] :
    name => var.gateway
    if name != null
  }

  active_active = each.value.active_active

  dynamic "bgp_settings" {
    for_each = { for bgp_setting in [each.value.bgp_settings] : bgp_setting.asn => bgp_setting if bgp_setting != null }
    content {
      asn = bgp_settings.value.asn

      dynamic "peering_addresses" {
        for_each = {
          for peering_address in coalesce(bgp_settings.value.peering_addresses, []) :
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
    for_each = { for index, custom_route in [each.value.custom_route] : index => custom_route if custom_route != null }
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
      coalesce(ip_configuration.name, "vnetGatewayConfig") => ip_configuration
      if ip_configuration.public_ip_address_id != null
    }
    content {
      name                          = ip_configuration.value.name
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      subnet_id                     = azurerm_subnet.name["GatewaySubnet"].id
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
    }
  }

  location                   = coalesce(each.value.location, var.location)
  name                       = each.value.name
  private_ip_address_enabled = each.value.private_ip_address_enabled
  resource_group_name        = coalesce(each.value.resource_group_name, var.resource_group_name)
  sku                        = each.value.sku
  type                       = each.value.type
  vpn_type                   = each.value.vpn_type

  dynamic "vpn_client_configuration" {
    for_each = { for index, vpn_configuration in [each.value.vpn_client_configuration] : index => vpn_configuration }
    content {
      address_space = vpn_client_configuration.value.address_space
      aad_tenant    = vpn_client_configuration.value.aad_tenant
      aad_audience  = vpn_client_configuration.value.aad_audience
      aad_issuer    = vpn_client_configuration.value.aad_issuer

      dynamic "root_certificate" {
        for_each = {
          for root_certificate in coalesce(vpn_client_configuration.value.root_certificates, []) :
          root_certificate.name => root_certificate.public_cert_data
        }
        content {
          name = root_certificate.key
          public_cert_data = trimspace(
            regex(
              "(?s)(-----BEGIN CERTIFICATE-----)(.*)(-----END CERTIFICATE-----)",
              root_certificate.value
            )[1]
          )
        }
      }

      dynamic "revoked_certificate" {
        for_each = {
          for revoked_certificate in coalesce(vpn_client_configuration.value.revoked_certificates, []) :
          revoked_certificate.name => revoked_certificate.thumbprint
        }
        content {
          name       = revoked_certificate.key
          thumbprint = revoked_certificate.value
        }
      }

      radius_server_address = vpn_client_configuration.value.radius_server_address
      radius_server_secret  = vpn_client_configuration.value.radius_server_secret
      vpn_client_protocols  = vpn_client_configuration.value.vpn_client_protocols
      vpn_auth_types        = vpn_client_configuration.value.vpn_auth_types
    }
  }

  tags = merge(var.tags, each.value.tags)

  depends_on = [
    azurerm_subnet.name,
  ]
}
