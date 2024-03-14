variable "subscription_id" {
  type = string
}

variable "email_address" {
  type = string
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "base_zone_name" {
  type = string
}

variable "base_zone_resource_group_name" {
  type = string
}

variable "shared_subscription_id" {
  type    = string
  default = null
}

variable "create_acme_both" {
  type    = bool
  default = false
}
