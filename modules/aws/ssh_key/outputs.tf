output "name" {
  description = "Name of the SSH key"
  value       = aws_key_pair.this.key_name
}
