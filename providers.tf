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
  features {}
}

provider "equinix" {
  auth_token = var.equinix_auth_token
}
