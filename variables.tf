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
  default     = "hil"
}

variable "hetzner_server_type" {
  description = "Hetzner Server Type"
  type        = string
  default     = "ccx23" # AMD Milan or Genoa
}

# AWS
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-west-2"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "aws_token" {
  description = "AWS Session Token"
  type        = string
}

variable "aws_instance_type" {
  description = "AWS Instance Type"
  type        = string
  default     = "c6a.xlarge" # AMD Milan
}

# Azure
variable "azure_region" {
  description = "Azure Region"
  type        = string
  default     = "West US"
}

variable "azure_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "azure_vm_size" {
  description = "Azure VM Size"
  type        = string
  default     = "Standard_D4ads_v5" # AMD Milan
}

# Equinix
variable "equinix_project_id" {
  description = "Equinix Project ID"
  type        = string
}

variable "equinix_auth_token" {
  description = "Equinix Auth Token"
  type        = string
}

variable "equinix_metro" {
  description = "Equinix Metro"
  type        = string
  default     = "se"
}

variable "equinix_device_plan" {
  description = "Equinix Device Plan"
  type        = string
  default     = "c3.medium.x86" # AMD Rome; INCOMPATIBLE with CPU template, use c3.medium.opt-c1 if available instead
}

# GCP
variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP Region"
  type        = string
  default     = "us-west1"
}

variable "gcp_zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-west1-a"
}

variable "gcp_machine_type" {
  description = "GCP Machine Type"
  type        = string
  default     = "t2d-standard-4" # AMD Genoa
}
