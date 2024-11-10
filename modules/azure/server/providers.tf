terraform {
  required_providers {
    azurerm = {
      source                = "opentofu/azurerm"
      version               = "~> 4.0"
      configuration_aliases = [azurerm.primary]
    }
  }
}
