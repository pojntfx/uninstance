variable "name" {
  description = "Name of the server"
  type        = string
}

variable "image" {
  description = "Image to use for the server"
  type        = string
}

variable "server_type" {
  description = "Type of the server"
  type        = string
}

variable "location" {
  description = "Location where the server will be created"
  type        = string
}

variable "user_data" {
  description = "User data (cloud-init) contents"
  type        = string
}

variable "ssh_key_ids" {
  description = "List of SSH key IDs to attach to the server"
  type        = list(string)
}

variable "firewall_ids" {
  description = "List of firewall IDs to attach to the server"
  type        = list(string)
}
