output "ipv4_address" {
  description = "IPv4 address of the server"
  value       = azurerm_public_ip.ipv4_address.ip_address
}

output "ipv6_address" {
  description = "IPv6 address of the server"
  value       = azurerm_public_ip.ipv6_address.ip_address
}

output "user" {
  description = "User of the server"
  value       = azurerm_linux_virtual_machine.this.admin_username
}
