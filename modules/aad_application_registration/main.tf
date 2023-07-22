locals {}

data "azuread_client_config" "current" {}

resource "random_uuid" "uuid" {
  count = 2
}


resource "azuread_application" "aad_application" {
  display_name            = "${var.project}-${var.environment}-apps"
  prevent_duplicate_names = true
  owners                  = var.app_owners != "" ? [data.azuread_client_config.current.object_id, var.app_owners] : [data.azuread_client_config.current.object_id]

  web {
    redirect_uris = var.web_redirect_uris
    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }

  api {
    mapped_claims_enabled = true

    oauth2_permission_scope {
      admin_consent_description  = "Allow the application to access ${var.project}-${var.environment} on behalf of the signed-in user."
      admin_consent_display_name = "Create and access protected content for the user"
      enabled                    = true
      id                         = random_uuid.uuid[0].result
      type                       = "User"
      user_consent_description   = "Allow the application to access ${var.project}-${var.environment} on your behalf."
      user_consent_display_name  = "User impersonation scope"
      value                      = "user_impersonation"
    }

    oauth2_permission_scope {
      admin_consent_description  = "Administer of the ${var.project}-${var.environment} application"
      admin_consent_display_name = "Administer"
      enabled                    = true
      id                         = random_uuid.uuid[1].result
      type                       = "Admin"
      value                      = "administer"
    }
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
    "webApp",      # Created by Azure, added so its ignored instead of being removed.
    "apiConsumer", # Created by Azure, added so its ignored instead of being removed.
  ]
}

resource "azuread_application_password" "aad_application_password" {
  application_object_id = azuread_application.aad_application.object_id
  display_name          = "${var.project}-${var.environment}-app-client-secret"

  rotate_when_changed = {
    rotation = time_rotating.aad_application_password_rotation.id
  }

  depends_on = [azuread_application.aad_application]
}

resource "time_rotating" "aad_application_password_rotation" {
  rotation_days = 180
}
