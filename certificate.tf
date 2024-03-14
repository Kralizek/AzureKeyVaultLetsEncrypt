resource "random_password" "cert" {
  length  = 24
  special = true
}

resource "acme_certificate" "certificate" {
  account_key_pem          = acme_registration.reg.account_key_pem
  common_name              = "*.${azurerm_dns_zone.this.name}"
  certificate_p12_password = random_password.cert.result

  dns_challenge {
    provider = "azuredns"

    config = {
      "AZURE_CLIENT_ID"           = data.azurerm_client_config.current.client_id
      "AZURE_TENANT_ID"           = data.azurerm_client_config.current.tenant_id
      "AZURE_SUBSCRIPTION_ID"     = var.subscription_id
      "AZURE_RESOURCE_GROUP"      = azurerm_resource_group.this.name
      "AZURE_ZONE_NAME"           = azurerm_dns_zone.this.name
      "AZURE_TTL"                 = 60
      "AZURE_PROPAGATION_TIMEOUT" = 1500
    }
  }

  depends_on = [azurerm_dns_ns_record.this]

  provider = acme.staging
}

resource "azurerm_key_vault_certificate" "certificate" {
  name         = "cert-${local.resource_base_name}"
  key_vault_id = azurerm_key_vault.this.id

  certificate {
    contents = acme_certificate.certificate.certificate_p12
    password = random_password.cert.result
  }

  depends_on = [azurerm_role_assignment.current_user]
}
