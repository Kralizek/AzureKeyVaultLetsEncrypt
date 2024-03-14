resource "azurerm_key_vault" "this" {
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  name                      = "kv-certs-${local.resource_base_name}"
  sku_name                  = "standard"
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  enable_rbac_authorization = true
}

resource "azurerm_role_assignment" "current_user" {
  scope                = azurerm_key_vault.this.id
  principal_id         = data.azurerm_client_config.current.object_id
  role_definition_name = "Key Vault Certificates Officer"
}
