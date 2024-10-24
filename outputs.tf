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

