output "tenant_id" {
  description = <<-EOF
    The tenant ID used for this subscription.

EOF

  value = var.arm_tenant_id
}

output "linux_web_app_python_site" {
  description = <<-EOF
    The url to the python web app.

EOF

  value = module.linux_web_apps.linux_web_app_python_site
}

output "linux_web_app_nodejs_site" {
  description = <<-EOF
    The url to the nodejs web app

EOF

  value = module.linux_web_apps.linux_web_app_nodejs_site
}