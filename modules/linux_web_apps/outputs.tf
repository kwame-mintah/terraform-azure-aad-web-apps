output "linux_service_plan_name" {
  description = <<-EOF
    The name of the service plan created for the App Service.

EOF

  value = azurerm_service_plan.linux_service_plan.name
}

output "linux_web_app_python_site" {
  description = <<-EOF
    The url to the python web app.

EOF

  value = azurerm_linux_web_app.linux_web_app_python.default_hostname
}

output "linux_web_app_nodejs_site" {
  description = <<-EOF
    The url to the nodejs web app

EOF

  value = azurerm_linux_web_app.linux_web_app_nodejs.default_hostname
}