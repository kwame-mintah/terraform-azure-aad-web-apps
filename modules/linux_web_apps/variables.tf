variable "aad_v2_client_id" {
  description = <<-EOF
    The ID of the Client to use to 
    authenticate with Azure Active Directory.
    
EOF

  type = string
}

variable "aad_v2_tenant_auth_endpoint" {
  description = <<-EOF
    The Azure Tenant Endpoint for the 
    Authenticating Tenant. 
    
EOF

  type = string
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

variable "resource_group" {
  description = <<-EOF
  The name of the resource group the resource is created in.

EOF

  type = string
}

variable "service_plan" {
  description = <<-EOF
  The pricing tier for hosting the resource.

EOF

  type    = string
  default = "F1"
}

