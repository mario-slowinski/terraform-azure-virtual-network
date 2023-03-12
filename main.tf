resource "azurerm_virtual_network" "this" {
  name                = coalesce(var.name, replace(join(var.separator, local.names), " ", var.space))
  resource_group_name = coalesce(var.resource_group_name, replace(join(var.separator, local.names), " ", var.space))
  location            = var.location
  address_space       = var.address_space

  tags = coalesce(var.tags, local.zip)
}
