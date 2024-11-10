terraform {
  required_providers {
    hcloud = {
      source                = "opentofu/hcloud"
      version               = "~> 1.0"
      configuration_aliases = [hcloud.primary]
    }
  }
}
