variable "subnets" {
  type = list(object({
    address_prefixes = list(string)      # The list of address prefixes to use for the subnet.
    delegations = optional(list(object({ # A delegation block.
      name = string                      # A name for this delegation.
      service_delegation = object({
        name    = string                 # The name of service to delegate to.
        actions = optional(list(string)) # A list of Actions which should be delegated.
      })
    })))
    name                                          = string                 # The name of the subnet.
    private_endpoint_network_policies_enabled     = optional(bool)         # Enable or Disable network policies for the private endpoint on the subnet.
    private_link_service_network_policies_enabled = optional(bool)         # Enable or Disable network policies for the private link service on the subnet.
    resource_group_name                           = optional(string)       # The name of the resource group in which to create the subnet. Use virtual network's if not defined
    service_endpoints                             = optional(list(string)) # The list of Service endpoints to associate with the subnet.
    service_endpoint_policy_ids                   = optional(list(string)) # The list of IDs of Service Endpoint Policies to associate with the subnet.
  }))
  description = "Manages a subnet. Subnets represent network segments within the IP space defined by the virtual network."
  default = [
    {
      address_prefixes = null
      name             = null
    }
  ]
}
