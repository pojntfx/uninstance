terraform {
  required_providers {
    hcloud = {
      source  = "opentofu/hcloud"
      version = "1.26.1"
    }

    aws = {
      source  = "opentofu/aws"
      version = "~> 5.0"
    }

    azurerm = {
      source  = "opentofu/azurerm"
      version = "~> 4.0"
    }

    equinix = {
      source  = "equinix/equinix"
      version = "~> 1.0"
    }

    google = {
      source  = "opentofu/google"
      version = "~> 6.4"
    }
  }
}

provider "hcloud" {
  token = var.hetzner_api_key
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
}

provider "azurerm" {
  subscription_id = var.azure_subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "equinix" {
  auth_token = var.equinix_auth_token
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}
