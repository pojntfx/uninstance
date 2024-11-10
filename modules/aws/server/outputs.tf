output "ipv4_address" {
  description = "IPv4 address of the server"
  value       = aws_instance.this.public_ip
}

output "ipv6_address" {
  description = "IPv6 address of the server"
  value       = aws_instance.this.ipv6_addresses[0]
}

output "user" {
  description = "User of the server"
  value       = "ec2-user"
}
