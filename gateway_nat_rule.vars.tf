variable "gateway_nat_rules" {
  type = list(object({
    name                    = string           # The name which should be used for this Virtual Network Gateway Nat Rule.
    resource_group_name     = optional(string) # The Name of the Resource Group in which this Virtual Network Gateway Nat Rule should be created.
    virtual_network_gateway = string           # The ID or Name of the Virtual Network Gateway that this Virtual Network Gateway Nat Rule belongs to.
    external_mappings = list(object({
      address_space = string           # The string CIDR representing the address space for the Virtual Network Gateway Nat Rule external mapping.
      port_range    = optional(string) # The single port range for the Virtual Network Gateway Nat Rule external mapping.
    }))
    internal_mappings = list(object({
      address_space = string           # The string CIDR representing the address space for the Virtual Network Gateway Nat Rule internal mapping.
      port_range    = optional(string) #  The single port range for the Virtual Network Gateway Nat Rule internal mapping.
    }))
    ip_configuration_id = optional(string) # The ID of the IP Configuration this Virtual Network Gateway Nat Rule applies to.
    mode                = optional(string) # The source Nat direction of the Virtual Network Gateway Nat. Possible values are EgressSnat and IngressSnat. Defaults to EgressSnat.
    type                = optional(string) # The type of the Virtual Network Gateway Nat Rule. Possible values are Dynamic and Static. Defaults to Static.
  }))
  description = "List of Virtual Network Gateway Nat Rules."
  default = [
    {
      name                    = null
      virtual_network_gateway = null
      external_mappings       = [{ address_space = null }]
      internal_mappings       = [{ address_space = null }]
    }
  ]
}
