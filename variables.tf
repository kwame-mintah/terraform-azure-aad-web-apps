variable "arm_client_id" {
  description = <<-EOF
  The Client ID which should be used. This can also be sourced 
  from the ARM_CLIENT_ID Environment Variable.

EOF

  type = string

}

variable "arm_client_secret" {
  description = <<-EOF
  The Client Secret which should be used. This can also be sourced 
  from the ARM_CLIENT_SECRET Environment Variable.

EOF

  type = string

}

variable "arm_tenant_id" {
  description = <<-EOF
  The Tenant ID which should be used. This can also be sourced 
  from the ARM_TENANT_ID Environment Variable.

EOF

  type = string

}

variable "arm_subscription_id" {
  description = <<-EOF
  The Subscription ID which should be used. This can also be sourced 
  from the ARM_SUBSCRIPTION_ID Environment Variable.

EOF

  type = string

}

variable "add_app_owners" {
  description = <<-EOF
    Add additional owners to the application registration,
    by defualt the caller is added.
    
EOF

  type    = string
  default = ""
}

variable "add_web_redirect_uris" {
  description = <<-EOF
    Add additional redirect uris the application registration,
    comma seperated and a valid uri.
    
EOF

  type    = string
  default = ""
}

variable "cloud_enviornment" {
  description = <<-EOF
  The Cloud Environment which should be used. Possible values are public,
  `usgovernment`, `german`, and `china`. Defaults to `public`. This can also be 
  sourced from the ARM_ENVIRONMENT Environment Variable.

EOF

  type    = string
  default = "public"

}

variable "common_tags" {
  description = <<-EOF
    Tags to be added to resources created.
    
EOF

  type    = map(string)
  default = {}
}

variable "environment" {
  description = <<-EOF
  The name of the _environment_ to help identify resources.

EOF

  type = string
}

variable "location" {
  description = <<-EOF
  The Azure Region where the resource should exist.

EOF

  type    = string
  default = "West Europe"
}

variable "project" {
  description = <<-EOF
  The name of the Azure DevOps project the resource belongs to.

EOF

  type = string
}

variable "web_app_service_plan" {
  description = <<-EOF
  The app service pricing plan.

EOF

  type    = string
  default = "F1"
}
