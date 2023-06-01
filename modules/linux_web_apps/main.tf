locals {
  name_prefix = "${var.project}-${var.environment}"
  common_tags = var.common_tags
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
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    "FRONTEND_SERVICE_URL"           = "https://${azurerm_linux_web_app.linux_web_app_nodejs.default_hostname}"
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
  }
  site_config {
    always_on = var.environment == "development" ? "false" : "true"
    application_stack {
      node_version = "18-lts"
    }
    app_command_line = "pm2 serve /home/site/wwwroot --spa --no-daemon"
  }
  tags = merge(
    local.common_tags,
    {
      "App_Type" = "nodejs"
    }
  )
}
