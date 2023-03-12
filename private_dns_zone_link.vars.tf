variable "private_dns_zones" {
  type = list(object({
    name                  = optional(string)
    private_dns_zone_name = string
    resource_group_name   = optional(string)
    registration_enabled  = optional(bool)
    tags                  = optional(map(string))
  }))
  description = "List of private DNS Zones to link to this virtual network."
  default     = []
}
