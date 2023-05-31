# Linux Web Apps Module

An App Service module for creating an Nodejs and Python app service. See [naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules),
if there is any issue with the resource name.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | = 1.4.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.58.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | = 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.58.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_web_app.linux_web_app_nodejs](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/linux_web_app) | resource |
| [azurerm_linux_web_app.linux_web_app_python](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/linux_web_app) | resource |
| [azurerm_service_plan.linux_service_plan](https://registry.terraform.io/providers/hashicorp/azurerm/3.58.0/docs/resources/service_plan) | resource |
| [random_id.unique_name](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/id) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Tags to be added to resources created. | `map(string)` | `{}` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The name of the _environment_ to help identify resources. | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region where the resource should exist. | `string` | `"West Europe"` | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the Azure DevOps project the resource belongs to. | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group the resource is created in. | `string` | n/a | yes |
| <a name="input_service_plan"></a> [service\_plan](#input\_service\_plan) | The pricing tier for hosting the resource. | `string` | `"F1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linux_service_plan_name"></a> [linux\_service\_plan\_name](#output\_linux\_service\_plan\_name) | The name of the service plan created for the App Service. |
| <a name="output_linux_web_app_nodejs_site"></a> [linux\_web\_app\_nodejs\_site](#output\_linux\_web\_app\_nodejs\_site) | The url to the nodejs web app |
| <a name="output_linux_web_app_python_site"></a> [linux\_web\_app\_python\_site](#output\_linux\_web\_app\_python\_site) | The url to the python web app. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK --->
