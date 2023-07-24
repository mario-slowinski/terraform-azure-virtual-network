variable "peerings" {
  type = list(object({
    name                         = string                # The name of the virtual network peering.
    remote_virtual_network_id    = string                # The full Azure resource ID of the remote virtual network.
    resource_group_name          = optional(string)      # The name of the resource group in which to create the virtual network peering.
    allow_virtual_network_access = optional(bool)        # Controls if the VMs in the remote virtual network can access VMs in the local virtual network.
    allow_forwarded_traffic      = optional(bool)        # Controls if forwarded traffic from VMs in the remote virtual network is allowed.
    allow_gateway_transit        = optional(bool)        # Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network.
    use_remote_gateways          = optional(bool)        # Controls if remote gateways can be used on the local virtual network.
    triggers                     = optional(map(string)) # A mapping of key values pairs that can be used to sync network routes from the remote virtual network to the local virtual network.
  }))
  description = "List of virtual network peerings which allows resources to access other resources in the linked virtual network."
  default     = [{ name = null, remote_virtual_network_id = null }]
}
