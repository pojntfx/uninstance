variable "name" {
  description = "Name of the server"
  type        = string
}

variable "image" {
  description = "Image to use for the server"
  type        = string
}

variable "machine_type" {
  description = "Machine type of the server"
  type        = string
}

variable "disk_size" {
  description = "Disk size to use for the server"
  type        = number
}

variable "region" {
  description = "Region where the server will be created"
  type        = string
}

variable "zone" {
  description = "Zone where the server will be created"
  type        = string
}

variable "public_key" {
  description = "SSH public key contents"
  type        = string
}

variable "user_data" {
  description = "User data (cloud-init) contents"
  type        = string
}
