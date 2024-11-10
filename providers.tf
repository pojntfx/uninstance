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
