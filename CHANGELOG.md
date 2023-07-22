## v0.1.0 (2023-07-22)

### Feat

- **linux_web_apps**: add new app settings env var
- **pre-commit-config**: update pre-commit hook versions
- **staging**: deploy staging resources
- **development**: add new redirect uri for local
- **aad_applications**: allow additional redirect uris to be configured
- **develop**: create app registration resources
- **aad_application_registration**: module for creating app registration
- **development**: create app service resources in dev
- **linux_web_apps**: create app service resources
- **linux_web_apps**: create module for creation of app services
- **environments**: add `terragrunt.hcl` to each environment
- **.tflint**: add `.tflint.hcl` rules and also include `azurerm` plugin
- **terraform**: init terraform files for azurem provider
- **terraform**: init terraform and terragrunt configuration files
- **git**: init git configuration for project

### Refactor

- **linux_web_apps**: allow for service plan to be changed
- **linux_web_apps**: amend start up command for nodejs app
- **aad_application_registration**: ensure app registration is created before applying credential secrets
- **gitignore**: add `.log` and .history directory to ignore
- **linux_web_apps**: add new locals to module
- **pre-commit-config**: format other files in subdirectories
- **linux_web_apps**: add tags and update python command line
