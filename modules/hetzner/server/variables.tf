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

variable "public_key_id" {
  description = "SSH public key ID"
  type        = string
}

variable "user_data" {
  description = "User data (cloud-init) contents"
  type        = string
}
