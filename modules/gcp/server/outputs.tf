output "ipv4_address" {
  description = "IPv4 address of the server"
  value       = google_compute_address.ipv4_address.address
}

output "ipv6_address" {
  description = "IPv6 address of the server"
  value       = google_compute_instance.this.network_interface[0].ipv6_access_config[0].external_ipv6
}

output "user" {
  description = "User of the server"
  value       = "gcp-user"
}
