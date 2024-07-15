variable "gateway_connections" {
  type = list(object({
    name                            = string           # The name of the connection. Changing the name forces a new resource to be created.
    resource_group_name             = optional(string) # The name of the resource group in which to create the connection. Use virtual_network's if not defined.
    location                        = optional(string) # The location/region where the connection is located. Use virtual_network's if not defined.
    type                            = string           # The type of connection. Valid options are IPsec (Site-to-Site), ExpressRoute (ExpressRoute), and Vnet2Vnet (VNet-to-VNet).
    virtual_network_gateway         = optional(string) # The ID or name of the Virtual Network Gateway in which the connection will be created. Use the one from module if set to null.
    authorization_key               = optional(string) # The authorization key associated with the Express Route Circuit. Changing this forces a new resource to be created.
    dpd_timeout_seconds             = optional(string) # The dead peer detection timeout of this connection in seconds. Changing this forces a new resource to be created.
    express_route_circuit_id        = optional(string) # The ID of the Express Route Circuit when creating an ExpressRoute connection (i.e. when type is ExpressRoute). The Express Route Circuit can be in the same or in a different subscription. Changing this forces a new resource to be created.
    peer_virtual_network_gateway_id = optional(string) # The ID of the peer virtual network gateway when creating a VNet-to-VNet connection (i.e. when type is Vnet2Vnet). The peer Virtual Network Gateway can be in the same or in a different subscription. Changing this forces a new resource to be created.
    local_azure_ip_address_enabled  = optional(bool)   # Use private local Azure IP for the connection. Changing this forces a new resource to be created.
    local_network_gateway           = optional(string) # The ID or name of the local network gateway when creating Site-to-Site connection (i.e. when type is IPsec).
    routing_weight                  = optional(number) # The routing weight. Defaults to 10.
    shared_key                      = optional(string) # The shared IPSec key. A key could be provided if a Site-to-Site, VNet-to-VNet or ExpressRoute connection is created.
    connection_mode                 = optional(string) # Connection mode to use. Possible values are Default, InitiatorOnly and ResponderOnly. Defaults to Default. Changing this value will force a resource to be created.
    connection_protocol             = optional(string) # The IKE protocol version to use. Possible values are IKEv1 and IKEv2, values are IKEv1 and IKEv2. Defaults to IKEv2. Changing this forces a new resource to be created.
    enable_bgp                      = optional(bool)   # If true, BGP (Border Gateway Protocol) is enabled for this connection. Defaults to false.
    custom_bgp_addresses = optional(object({
      primary   = string           # single IP address that is part of the azurerm_virtual_network_gateway ip_configuration (first one)
      secondary = optional(string) # Single IP address that is part of the azurerm_virtual_network_gateway ip_configuration (second one)
    }))
    express_route_gateway_bypass       = optional(bool)         # If true, data packets will bypass ExpressRoute Gateway for data forwarding This is only valid for ExpressRoute connections.
    private_link_fast_path_enabled     = optional(bool)         # Bypass the Express Route gateway when accessing private-links. When enabled express_route_gateway_bypass must be set to true. Defaults to false.
    egress_nat_rule_ids                = optional(list(string)) # A list of the egress NAT Rule Ids.
    ingress_nat_rule_ids               = optional(list(string)) # A list of the ingress NAT Rule Ids.
    use_policy_based_traffic_selectors = optional(bool)         # If true, policy-based traffic selectors are enabled for this connection. Enabling policy-based traffic selectors requires an ipsec_policy block. Defaults to false.
    ipsec_policy = optional(object({
      dh_group         = string           # The DH group used in IKE phase 1 for initial SA. Valid options are DHGroup1, DHGroup14, DHGroup2, DHGroup2048, DHGroup24, ECP256, ECP384, or None.
      ike_encryption   = string           # The IKE encryption algorithm. Valid options are AES128, AES192, AES256, DES, DES3, GCMAES128, or GCMAES256.
      ike_integrity    = string           # The IKE integrity algorithm. Valid options are GCMAES128, GCMAES256, MD5, SHA1, SHA256, or SHA384.
      ipsec_encryption = string           # The IPSec encryption algorithm. Valid options are AES128, AES192, AES256, DES, DES3, GCMAES128, GCMAES192, GCMAES256, or None.
      ipsec_integrity  = string           # The IPSec integrity algorithm. Valid options are GCMAES128, GCMAES192, GCMAES256, MD5, SHA1, or SHA256.
      pfs_group        = string           # The DH group used in IKE phase 2 for new child SA. Valid options are ECP256, ECP384, PFS1, PFS14, PFS2, PFS2048, PFS24, PFSMM, or None.
      sa_datasize      = optional(string) # The IPSec SA payload size in KB. Must be at least 1024 KB. Defaults to 102400000 KB.
      sa_lifetime      = optional(string) # The IPSec SA lifetime in seconds. Must be at least 300 seconds. Defaults to 27000 seconds.
    }))
    traffic_selector_policies = optional(list(object({
      local_address_cidrs  = list(string) # List of local CIDRs.
      remote_address_cidrs = list(string) # List of remote CIDRs.
    })))
    tags = optional(map(string)) # A mapping of tags to assign to the resource.
  }))
  description = "Manages a connection in an existing Virtual Network Gateway."
  default     = [{ name = null, type = null }]
}
