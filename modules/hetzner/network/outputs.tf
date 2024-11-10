output "id" {
  description = "ID of the firewall"
  value       = hcloud_firewall.this.id
}

output "name" {
  description = "Name of the firewall"
  value       = hcloud_firewall.this.name
}
