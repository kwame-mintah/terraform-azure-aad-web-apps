# UoW Infrastructure Terraform

This repository will deploy Azure Web Apps and configure Azure Active Directory (AAD) for the [UoW Frontend App](https://dev.azure.com/k-space/uow/_git/uow-frontend-app) and [UoW Backend App](https://dev.azure.com/k-space/uow/_git/uow-backend-app).

## Development

### Dependencies

- [terraform](https://www.terraform.io/)
- [terragrunt](https://terragrunt.gruntwork.io/)
- [pre-commit](https://pre-commit.com/)
- [terraform-docs](https://terraform-docs.io/) this is required for `terraform_docs` hooks

## Prerequisites

1. Have a [Azure Portal](https://portal.azure.com/) account. 
2. You will need to create a Service Principal with a Client Secret [follow instructions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal-in-the-azure-portal).

## Usage

1. Navigate to the environment you would like to deploy,
2. Plan your changes with `terragrunt plan` to see what changes will be made,
3. If you're happy with the changes `terragrunt apply`.

Please note that `.tfstate` files are stored locally on your machine as no backend has been specified. If you would like to properly version control your state files, it is possible to use an S3 bucket to store these files. 
This will ensure anyone else other than you running a plan/apply will always be using the same state file.

## Pre-Commit hooks

Git hook scripts are very helpful for identifying simple issues before pushing any changes. Hooks will run on every commit automatically pointing out issues in the code e.g. trailing whitespace.

To help with the maintenance of these hooks, [pre-commit](https://pre-commit.com/) is used, along with [pre-commit-hooks](https://pre-commit.com/#install).

Please following [these instructions](https://pre-commit.com/#install) to install `pre-commit` locally and ensure that you have run `pre-commit install` to install the hooks for this project.

Additionally, once installed, the hooks can be updated to the latest available version with `pre-commit autoupdate`.

## Documentation Generation

Code formatting and documentation for `variables` and `outputs` is generated using [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform/releases) hooks that in turn uses [terraform-docs](https://github.com/terraform-docs/terraform-docs) that will insert/update documentation. The following markers have been added to the `README.md`:
```
<!-- {BEGINNING|END} OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.4.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.58.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.58.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aad_applications"></a> [aad\_applications](#module\_aad\_applications) | ./modules/aad_application_registration | n/a |
| <a name="module_linux_web_apps"></a> [linux\_web\_apps](#module\_linux\_web\_apps) | ./modules/linux_web_apps | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_add_app_owners"></a> [add\_app\_owners](#input\_add\_app\_owners) | Add additional owners to the application registration,<br>by defualt the caller is added. | `string` | `""` | no |
| <a name="input_add_web_redirect_uris"></a> [add\_web\_redirect\_uris](#input\_add\_web\_redirect\_uris) | Add additional redirect uris the application registration,<br>comma seperated and a valid uri. | `string` | `""` | no |
| <a name="input_arm_client_id"></a> [arm\_client\_id](#input\_arm\_client\_id) | The Client ID which should be used. This can also be sourced <br>from the ARM\_CLIENT\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_client_secret"></a> [arm\_client\_secret](#input\_arm\_client\_secret) | The Client Secret which should be used. This can also be sourced <br>from the ARM\_CLIENT\_SECRET Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_subscription_id"></a> [arm\_subscription\_id](#input\_arm\_subscription\_id) | The Subscription ID which should be used. This can also be sourced <br>from the ARM\_SUBSCRIPTION\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_arm_tenant_id"></a> [arm\_tenant\_id](#input\_arm\_tenant\_id) | The Tenant ID which should be used. This can also be sourced <br>from the ARM\_TENANT\_ID Environment Variable. | `string` | n/a | yes |
| <a name="input_cloud_enviornment"></a> [cloud\_enviornment](#input\_cloud\_enviornment) | The Cloud Environment which should be used. Possible values are public,<br>`usgovernment`, `german`, and `china`. Defaults to `public`. This can also be <br>sourced from the ARM\_ENVIRONMENT Environment Variable. | `string` | `"public"` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the _environment_ to help identify resources. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the resource should exist. | `string` | `"West Europe"` | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the Azure DevOps project the resource belongs to. | `string` | n/a | yes |
| <a name="input_web_app_service_plan"></a> [web\_app\_service\_plan](#input\_web\_app\_service\_plan) | The app service pricing plan. | `string` | `"F1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aad_application_client_secret_value"></a> [aad\_application\_client\_secret\_value](#output\_aad\_application\_client\_secret\_value) | The secret value for this application, which is generated by Azure AD. |
| <a name="output_aad_applications_id"></a> [aad\_applications\_id](#output\_aad\_applications\_id) | Azure AD application id. |
| <a name="output_linux_web_app_nodejs_site"></a> [linux\_web\_app\_nodejs\_site](#output\_linux\_web\_app\_nodejs\_site) | The url to the nodejs web app |
| <a name="output_linux_web_app_python_site"></a> [linux\_web\_app\_python\_site](#output\_linux\_web\_app\_python\_site) | The url to the python web app. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | The tenant ID used for this subscription. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
