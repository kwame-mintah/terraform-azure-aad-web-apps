# Terragrunt will copy the Terraform files from the locations specified into this directory
terraform {
  source = "../.."
}

locals {
  environment = "development"
  project = "uow"
}

# These are inputs that need to be passed for the terragrunt configuration
inputs = {
  add_app_owners = "1239ac97-8ed6-4088-9670-14c8e238aed8"
  project = "uow"
  environment = "development"
  common_tags = {
    "Environment" = "development"
    "Project" = "uow"
    "Terraform" = "true"
  }
}

remote_state {
  backend = "local"
  config  = {
     path = "${get_parent_terragrunt_dir()}/${path_relative_to_include()}/${local.project}-terraform.tfstate"
  }
}
