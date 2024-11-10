variable "name" {
  description = "Name of the server"
  type        = string
}

variable "ami_owner" {
  description = "AMI owner"
  type        = string
}

variable "ami_name" {
  description = "AMI name"
  type        = string
}

variable "instance_type" {
  description = "Type of the instance"
  type        = string
}

variable "public_key_name" {
  description = "SSH public key name"
  type        = string
}

variable "user_data" {
  description = "User data (cloud-init) contents"
  type        = string
}
