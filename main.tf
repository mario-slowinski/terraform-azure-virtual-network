resource "azurerm_virtual_network" "this" {
  name                = coalesce(var.name, local.name)
  resource_group_name = coalesce(var.resource_group_name, local.name)
  location            = var.location
  address_space       = var.address_space

  tags = coalesce(var.tags, local.zip)
}
