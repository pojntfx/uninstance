# Hetzner
output "alma_hetzner_pvm_node_1_user" {
  description = "alma-hetzner-pvm-node-1 User"
  value       = "root"
}

output "alma_hetzner_pvm_node_1_ipv4_address" {
  description = "alma-hetzner-pvm-node-1 IPv4 Address"
  value       = hcloud_server.alma_hetzner_pvm_node_1.ipv4_address
}

output "alma_hetzner_pvm_node_1_ipv6_address" {
  description = "alma-hetzner-pvm-node-1 IPv6 Address"
  value       = hcloud_server.alma_hetzner_pvm_node_1.ipv6_address
}

# AWS
output "alma_aws_pvm_node_1_user" {
  description = "alma-aws-node-1 User"
  value       = "ec2-user"
}

output "alma_aws_pvm_node_1_ipv4_address" {
  description = "alma-aws-node-1 IPv4 Address"
  value       = aws_instance.alma_aws_pvm_node_1.public_ip
}

output "alma_aws_pvm_node_1_ipv6_address" {
  description = "alma-aws-node-1 IPv6 Address"
  value       = aws_instance.alma_aws_pvm_node_1.ipv6_addresses[0]
}

# Azure
output "alma_azure_pvm_node_1_user" {
  description = "alma-azure-pvm-node-1 User"
  value       = azurerm_linux_virtual_machine.alma_azure_pvm_node_1.admin_username
}

output "alma_azure_pvm_node_1_ipv4_address" {
  description = "alma-azure-pvm-node-1 IPv4 Address"
  value       = azurerm_public_ip.alma_azure_pvm_node_1_ip_ipv4.ip_address
}

output "alma_azure_pvm_node_1_ipv6_address" {
  description = "alma-azure-pvm-node-1 IPv6 Address"
  value       = azurerm_public_ip.alma_azure_pvm_node_1_ip_ipv6.ip_address
}

# Equinix
output "alma_equinix_pvm_node_1_user" {
  description = "alma-equinix-pvm-node-1 User"
  value       = "root"
}

output "alma_equinix_pvm_node_1_ipv4_address" {
  description = "alma-equinix-pvm-node-1 IPv4 Address"
  value = try(
    [
      for addr in equinix_metal_device.alma_equinix_pvm_node_1.network : addr.address
      if addr.family == 4 && addr.public == true
    ][0],
    null
  )
}

output "alma_equinix_pvm_node_1_ipv6_address" {
  description = "alma-equinix-pvm-node-1 IPv6 Address"
  value = try(
    [
      for addr in equinix_metal_device.alma_equinix_pvm_node_1.network : addr.address
      if addr.family == 6 && addr.public == true
    ][0],
    null
  )
}

# GCP
output "alma_gcp_pvm_node_1_user" {
  description = "alma-gcp-pvm-node-1 User"
  value       = "pojntfx"
}

output "alma_gcp_pvm_node_1_ipv4_address" {
  description = "alma-gcp-pvm-node-1 IPv4 Address"
  value       = google_compute_address.alma_gcp_pvm_node_1_ip_ipv4.address
}

output "alma_gcp_pvm_node_1_ipv6_address" {
  description = "alma-gcp-pvm-node-1 IPv6 Address"
  value       = google_compute_instance.alma_gcp_pvm_node_1.network_interface[0].ipv6_access_config[0].external_ipv6
}
