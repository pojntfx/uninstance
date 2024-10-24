terraform {
  required_providers {
    hcloud = {
      source  = "opentofu/hcloud"
      version = "1.26.1"
    }

  }
}

provider "hcloud" {
  token = var.hetzner_api_key
}
