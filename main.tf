data "azurerm_client_config" "current" {}

locals {
  resource_base_name = "kvle-test"
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "reg" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.email_address

  provider = acme.staging
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${local.resource_base_name}"
  location = var.location
}
