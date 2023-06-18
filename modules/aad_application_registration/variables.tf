variable "app_owners" {
  description = <<-EOF
    Add additional owners to the application registration,
    by defualt the caller is added.
    
EOF

  type    = string
  default = ""
}

variable "environment" {
  description = <<-EOF
  The name of the _environment_ to help identify resources.

EOF

  type = string
}

variable "project" {
  description = <<-EOF
  The name of the Azure DevOps project the resource belongs to.

EOF

  type = string
}

variable "web_redirect_uris" {
  description = <<-EOF
  (Optional) A set of URLs where user tokens are sent for sign-in, 
  or the redirect URIs where OAuth 2.0 authorization codes and access
  tokens are sent. Must be a valid http URL or a URN.

EOF

  type = set(string)
}
