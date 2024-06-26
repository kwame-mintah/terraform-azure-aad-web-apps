data "azurerm_client_config" "current" {}
locals {
  common_tags = merge(
    var.common_tags
  )
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  tenant_id       = var.arm_tenant_id
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  subscription_id = var.arm_subscription_id
  environment     = var.cloud_enviornment
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.project}-${var.environment}-resource"
  location = var.location
  tags = merge(
    local.common_tags
  )
}

module "linux_web_apps" {
  source         = "./modules/linux_web_apps"
  environment    = var.environment
  project        = var.project
  resource_group = azurerm_resource_group.resource_group.name
  service_plan   = var.web_app_service_plan
  common_tags = merge(
    local.common_tags
  )
  aad_v2_tenant_auth_endpoint = data.azurerm_client_config.current.tenant_id
  aad_v2_client_id            = "17a18884-ae6d-43a6-887a-e61819f671ca"
}

module "aad_applications" {
  source      = "./modules/aad_application_registration"
  app_owners  = var.add_app_owners
  environment = var.environment
  project     = var.project
  web_redirect_uris = [
    "https://${module.linux_web_apps.linux_web_app_nodejs_site}/.auth/login/aad/callback",
    "https://${module.linux_web_apps.linux_web_app_python_site}/.auth/login/aad/callback",
    var.add_web_redirect_uris != "" ? var.add_web_redirect_uris : null
  ]
}
