variable "local_network_gateways" {
  type = list(object({
    name                = string                 # The name of the connection. Changing the name forces a new resource to be created.
    resource_group_name = optional(string)       # The name of the resource group in which to create the connection. Use virtual_network's if not defined.
    location            = optional(string)       # The location/region where the connection is located. Use virtual_network's if not defined.
    address_space       = optional(list(string)) # The list of string CIDRs representing the address spaces the gateway exposes.
    bgp_settings = optional(object({
      asn                 = string           # The BGP speaker's ASN.
      bgp_peering_address = string           # The BGP peering address and BGP identifier of this BGP speaker.
      peer_weight         = optional(number) # The weight added to routes learned from this BGP speaker.
    }))
    gateway_address = optional(string)      # The gateway IP address to connect with.
    gateway_fqdn    = optional(string)      # The gateway FQDN to connect with.
    tags            = optional(map(string)) # A mapping of tags to assign to the resource.
  }))
  description = "Manages a local network gateway connection over which specific connections can be configured."
  default     = [{ name = null }]
}
