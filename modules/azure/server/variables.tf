variable "name" {
  description = "Name of the server"
  type        = string
}

variable "image_publisher" {
  description = "Image publisher"
  type        = string
}

variable "image_offer" {
  description = "Image offer"
  type        = string
}

variable "image_sku" {
  description = "Image SKU"
  type        = string
}

variable "image_version" {
  description = "Image version"
  type        = string
}

variable "size" {
  description = "Size of the server"
  type        = string
}

variable "location" {
  description = "Location where the server will be created"
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
