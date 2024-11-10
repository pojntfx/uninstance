terraform {
  required_providers {
    hcloud = {
      source  = "opentofu/hcloud"
      version = "~> 1.0"
    }

    aws = {
      source  = "opentofu/aws"
      version = "~> 5.0"
    }

    azurerm = {
      source  = "opentofu/azurerm"
      version = "~> 4.0"
    }

    google = {
      source  = "opentofu/google"
      version = "~> 6.4"
    }
  }
}
