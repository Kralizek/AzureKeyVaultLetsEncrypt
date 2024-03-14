module "keyvault_acmeboth" {
  count = var.create_acme_both ? 1 : 0
  source  = "shibayan/keyvault-acmebot/azurerm"
  version = "~> 3.0"

  app_base_name       = "cert${local.resource_base_name}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  mail_address = var.email_address

  vault_uri = azurerm_key_vault.this.vault_uri

  azure_dns = {
    subscription_id = var.subscription_id
  }
}

resource "azurerm_role_assignment" "acmebot" {
  count = var.create_acme_both ? 1 : 0
  scope                = azurerm_key_vault.this.id
  principal_id         = one(module.keyvault_acmeboth.*.principal_id)
  role_definition_name = "Key Vault Certificates Officer"
}
