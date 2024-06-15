variable "private_dns_zones" {
  type = list(object({
    name                  = optional(string)      # The name of the Private DNS Zone Virtual Network Link. Use var.name if not set.
    private_dns_zone_name = string                # The name of the Private DNS zone (without a terminating dot).
    resource_group_name   = optional(string)      # Specifies the resource group where the Private DNS Zone exists.
    registration_enabled  = optional(bool)        # Is auto-registration of virtual machine records in the virtual network in the Private DNS zone enabled?
    tags                  = optional(map(string)) # A mapping of tags to assign to the resource.
  }))
  description = "List of private DNS Zones to link to this virtual network."
  default     = [{ private_dns_zone_name = null }]
}
