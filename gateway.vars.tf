variable "gateway" {
  type = object({
    active_active = optional(bool) #  If true, an active-active Virtual Network Gateway will be created.
    bgp_settings = optional(object({
      asn = optional(string)                           # The Autonomous System Number (ASN) to use as part of the BGP.
      peering_addresses = optional(list(object({       # A list of peering_addresses as defined below.
        ip_configuration_name = optional(string)       # The name of the IP configuration of this Virtual Network Gateway.
        apipa_addresses       = optional(list(string)) # A list of Azure custom APIPA addresses assigned to the BGP peer of the Virtual Network Gateway.
      })))
      peer_weight = optional(number) # The weight added to routes which have been learned through BGP peering.
    }))
    custom_route = optional(object({
      address_prefixes = optional(list(string)) # A list of address blocks reserved for this virtual network in CIDR notation as defined below.
    }))
    default_local_network_gateway_id = optional(string) # The ID of the local network gateway through which outbound Internet traffic from the virtual network in which the gateway is created will be routed (forced tunnelling).
    edge_zone                        = optional(string) # Specifies the Edge Zone within the Azure Region where this Virtual Network Gateway should exist.
    enable_bgp                       = optional(bool)   # If true, BGP (Border Gateway Protocol) will be enabled for this Virtual Network Gateway.
    generation                       = optional(string) # The Generation of the Virtual Network gateway.
    ip_configurations = list(object({                   # One, two or three ip_configuration blocks.
      name                          = optional(string)  # A user-defined name of the IP configuration.
      private_ip_address_allocation = optional(string)  # Defines how the private IP address of the gateways virtual interface is assigned.
      public_ip_address_id          = string            # The ID of the public IP address to associate with the Virtual Network Gateway.
    }))
    location                   = optional(string) # The location/region where the Virtual Network Gateway is located. Use virtual_network's if not defined
    name                       = string           # The name of the Virtual Network Gateway.
    private_ip_address_enabled = optional(bool)   # Should private IP be enabled on this gateway for connections?
    resource_group_name        = optional(string) # The name of the resource group in which to create the Virtual Network Gateway. Use virtual_network's if not defined
    sku                        = string           # Configuration of the size and capacity of the virtual network gateway.
    tags                       = optional(map(string))
    type                       = string # The type of the Virtual Network Gateway.
    vpn_client_configuration = optional(object({
      address_space = string                     # The address space out of which IP addresses for vpn clients will be taken.
      aad_tenant    = optional(string)           # AzureAD Tenant URL.
      aad_audience  = optional(string)           # The client id of the Azure VPN application.
      aad_issuer    = optional(string)           # The STS url for your tenant.
      root_certificates = optional(list(object({ # One or more root_certificate blocks
        name             = string                # A user-defined name of the root certificate.
        public_cert_data = string                # The public certificate of the root certificate authority.
      })))
      revoked_certificates = optional(object({ # One or more revoked_certificate blocks
        name       = string                    # Specifies the name of the certificate resource.
        thumbprint = string                    # Specifies the public data of the certificate.
      }))
      radius_server_address = optional(string)       # The address of the Radius server.
      radius_server_secret  = optional(string)       # The secret used by the Radius server.
      vpn_client_protocols  = optional(string)       # List of the protocols supported by the vpn client.
      vpn_auth_types        = optional(list(string)) # List of the vpn authentication types for the virtual network gateway.
    }))
    vpn_type = optional(string) # The routing type of the Virtual Network Gateway.
  })
  description = "Manages a Virtual Network Gateway to establish secure, cross-premises connectivity."
  default = {
    ip_configurations = [{ subnet_id = null, public_ip_address_id = null }]
    name              = null
    sku               = null
    type              = "Vpn"
  }
}
