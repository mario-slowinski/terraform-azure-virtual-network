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
