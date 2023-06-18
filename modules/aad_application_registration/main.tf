locals {

}

data "azuread_client_config" "current" {}

resource "azuread_application" "aad_application" {
  display_name            = "${var.project}-${var.environment}-apps"
  prevent_duplicate_names = true
  owners                  = var.app_owners != "" ? [data.azuread_client_config.current.object_id, var.app_owners] : [data.azuread_client_config.current.object_id]

  single_page_application {
    redirect_uris = var.web_redirect_uris
  }

  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000" # Microsoft Graph
    resource_access {
      id   = "7427e0e9-2fba-42fe-b0c0-848c9e6a8182" # OpenId offline_access
      type = "Scope"
    }
    resource_access {
      id   = "37f7f235-527c-4136-accd-4a02d197296e" # Openid openid
      type = "Scope"
    }
  }

  tags = [
    "Managed By Terraform",
    var.project,
    var.environment,
    "webApp",      # Created by Azure, added so its ignored when being removed.
    "apiConsumer", # Created by Azure, added so its ignored when being removed.
  ]
}

resource "azuread_application_password" "aad_application_password" {
  application_object_id = azuread_application.aad_application.object_id
  display_name          = "${var.project}-${var.environment}-app-client-secret"

  rotate_when_changed = {
    rotation = time_rotating.aad_application_password_rotation.id
  }
}

resource "time_rotating" "aad_application_password_rotation" {
  rotation_days = 180
}