# Azure Active Directory Application Registration

This module will create a new application registration in the same tenant that the infrastructure has been configured to. The following API permissions will be needed
for your terraform principal (user creating azure resources): `Application.ReadWrite.All` or `Directory.ReadWrite.All`, `Application.ReadWrite.OwnedBy` and `User.Read.All` as per [docs](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/resources/application#api-permissions).

The application will be configured for integrating azure ad into an react / nodejs web application.

The following manual steps may need to be taken:
- [Enable self-service sign-up for your tenant](https://learn.microsoft.com/en-gb/azure/active-directory/external-identities/self-service-sign-up-user-flow#enable-self-service-sign-up-for-your-tenant)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.4.5 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.39.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.9.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.39.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |
| <a name="provider_time"></a> [time](#provider\_time) | 0.9.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.aad_application](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/resources/application) | resource |
| [azuread_application_password.aad_application_password](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/resources/application_password) | resource |
| [random_uuid.uuid](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/uuid) | resource |
| [time_rotating.aad_application_password_rotation](https://registry.terraform.io/providers/hashicorp/time/0.9.1/docs/resources/rotating) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.39.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_owners"></a> [app\_owners](#input\_app\_owners) | Add additional owners to the application registration,<br>by defualt the caller is added. | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the _environment_ to help identify resources. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The name of the Azure DevOps project the resource belongs to. | `string` | n/a | yes |
| <a name="input_web_redirect_uris"></a> [web\_redirect\_uris](#input\_web\_redirect\_uris) | (Optional) A set of URLs where user tokens are sent for sign-in, <br>or the redirect URIs where OAuth 2.0 authorization codes and access<br>tokens are sent. Must be a valid http URL or a URN. | `set(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aad_aapplication_object_id"></a> [aad\_aapplication\_object\_id](#output\_aad\_aapplication\_object\_id) | Azure AD application object id. |
| <a name="output_aad_application_client_secret_id"></a> [aad\_application\_client\_secret\_id](#output\_aad\_application\_client\_secret\_id) | A UUID used to uniquely identify this password credential. |
| <a name="output_aad_application_client_secret_value"></a> [aad\_application\_client\_secret\_value](#output\_aad\_application\_client\_secret\_value) | The secret value for this application, which is generated by Azure AD. |
| <a name="output_aad_application_id"></a> [aad\_application\_id](#output\_aad\_application\_id) | Azure AD application id. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
