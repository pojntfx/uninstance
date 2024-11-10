terraform {
  required_providers {
    google = {
      source                = "opentofu/google"
      version               = "~> 6.4"
      configuration_aliases = [google.primary]
    }
  }
}
