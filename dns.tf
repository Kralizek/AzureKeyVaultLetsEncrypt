data "azurerm_dns_zone" "parent" {
  resource_group_name = var.parent_zone_resource_group_name
  name                = var.parent_zone_name

  provider = azurerm.shared
}

resource "azurerm_dns_zone" "this" {
  resource_group_name = azurerm_resource_group.this.name
  name                = "${local.resource_base_name}.${data.azurerm_dns_zone.parent.name}"
}

resource "azurerm_dns_ns_record" "this" {
  name                = local.resource_base_name
  resource_group_name = var.parent_zone_resource_group_name
  zone_name           = var.parent_zone_name
  ttl                 = 3600
  records             = azurerm_dns_zone.this.name_servers

  provider = azurerm.shared
}
