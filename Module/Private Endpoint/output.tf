output "id" {
  value = azurerm_private_endpoint.this.id
}
output "subnet_id" {
  value = azurerm_private_endpoint.this.subnet_id
}

output "private_service_connection" {
  value = azurerm_private_endpoint.this.private_service_connection
}

output "nic" {
  value = azurerm_private_endpoint.this.network_interface
}

