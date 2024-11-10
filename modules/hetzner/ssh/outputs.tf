output "id" {
  description = "ID of the SSH key"
  value       = hcloud_ssh_key.this.id
}

output "name" {
  description = "Name of the SSH key"
  value       = hcloud_ssh_key.this.name
}
