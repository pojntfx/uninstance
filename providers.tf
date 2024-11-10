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

provider "hcloud" {
  alias = "primary"

  token = var.hetzner_api_key
}

provider "aws" {
  alias = "primary"

  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
}

provider "azurerm" {
  alias = "primary"

  subscription_id = var.azure_subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "google" {
  alias = "primary"

  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}
