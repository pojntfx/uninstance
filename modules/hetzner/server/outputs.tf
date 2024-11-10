output "ipv4_address" {
  description = "IPv4 address of the server"
  value       = hcloud_server.this.ipv4_address
}

output "ipv6_address" {
  description = "IPv6 address of the server"
  value       = hcloud_server.this.ipv6_address
}

output "user" {
  description = "User of the server"
  value       = "root"
}
