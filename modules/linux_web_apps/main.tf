locals {
  name_prefix      = "${var.project}-${var.environment}"
  common_tags      = var.common_tags
  python_site_name = "${local.name_prefix}-be-${random_id.unique_name.hex}.azurewebsites.net"
  nodejs_site_name = "${local.name_prefix}-fe-${random_id.unique_name.hex}.azurewebsites.net"
}

resource "random_id" "unique_name" {
  byte_length = 5
}

resource "azurerm_service_plan" "linux_service_plan" {
  name                = "${local.name_prefix}-${var.service_plan}"
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.service_plan
  tags                = merge(local.common_tags)
}

resource "azurerm_linux_web_app" "linux_web_app_python" {
  name                = "${local.name_prefix}-be-${random_id.unique_name.hex}"
  resource_group_name = var.resource_group
  location            = var.location
  service_plan_id     = azurerm_service_plan.linux_service_plan.id
  https_only          = true
  app_settings = {
    "SCM_DO_BUILD_DURING_DEPLOYMENT"  = "true"
    "ALLOW_CORS_ORIGINS"              = "https://${local.nodejs_site_name}"
    "SCM_COMMAND_IDLE_TIMEOUT"        = "1800"
    "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = "true"
  }
  site_config {
    always_on = var.environment == "development" ? "false" : "true"
    application_stack {
      python_version = "3.9"
    }
    app_command_line = "gunicorn -w 4 -k uvicorn.workers.UvicornWorker app.main:app"
  }
  tags = merge(
    local.common_tags,
    {
      "App_Type" = "python"
    }
  )
}

resource "azurerm_linux_web_app" "linux_web_app_nodejs" {
  name                = "${local.name_prefix}-fe-${random_id.unique_name.hex}"
  resource_group_name = var.resource_group
  location            = var.location
  service_plan_id     = azurerm_service_plan.linux_service_plan.id
  https_only          = true
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
    "BACKEND_SERVICE_URL"      = "https://${local.python_site_name}"
  }

  auth_settings_v2 {
    auth_enabled     = true
    default_provider = "azureactivedirectory"
    active_directory_v2 {
      client_id                  = var.aad_v2_client_id
      tenant_auth_endpoint       = "https://login.microsoftonline.com/v2.0/${var.aad_v2_tenant_auth_endpoint}/"
      client_secret_setting_name = "${var.project}-${var.environment}-apps"
    }
    login {}
  }
  site_config {
    always_on = var.environment == "development" ? "false" : "true"
    application_stack {
      node_version = "18-lts"
    }
    app_command_line = "pm2 start /home/site/wwwroot/ecosystem.config.js --no-daemon"
  }
  tags = merge(
    local.common_tags,
    {
      "App_Type" = "nodejs"
    }
  )
}
