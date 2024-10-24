# SSH
variable "ssh_public_key" {
  description = "SSH Public Key Location"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# Hetzner
variable "hetzner_api_key" {
  description = "Hetzner API Key"
  type        = string
}

variable "hetzner_location" {
  description = "Hetzner Location"
  type        = string
  default     = "nbg1"
}

# AWS
