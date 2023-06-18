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
  common_tags = merge(
    local.common_tags
  )
}

module "aad_applications" {
  source      = "./modules/aad_application_registration"
  app_owners  = var.add_app_owners
  environment = var.environment
  project     = var.project
  web_redirect_uris = [
    "https://${module.linux_web_apps.linux_web_app_nodejs_site}/auth/redirect/",
    "https://${module.linux_web_apps.linux_web_app_python_site}/",
  ]
}