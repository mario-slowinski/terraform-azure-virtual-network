variable "name" {
  type        = string
  description = "Resource's name."
  default     = ""
}

variable "resource_group_name" {
  type        = string
  description = "Specifies the name of the resource group the Virtual Network is located in."
  default     = ""
}

variable "address_space" {
  type        = list(string)
  description = "The list of address spaces used by the virtual network."
  default     = []
}

variable "location" {
  type        = string
  description = "Region to create resource."
  default     = ""
}

variable "ddos_protection_plan" {
  type = object({
    id     = string
    enable = bool
  })
  description = "Optional block."
  default = {
    id     = null
    enable = null
  }
}

variable "dns_servers" {
  type        = list(string)
  description = "List of IP addresses of DNS servers."
  default     = null
}

variable "edge_zone" {
  type        = string
  description = "Specifies the Edge Zone within the Azure Region where this Virtual Network should exist."
  default     = null
}

variable "flow_timeout_in_minutes" {
  type        = number
  description = "The flow timeout in minutes for the Virtual Network, which is used to enable connection tracking for intra-VM flows."
  default     = null
}
