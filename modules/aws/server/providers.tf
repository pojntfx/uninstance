terraform {
  required_providers {
    aws = {
      source                = "opentofu/aws"
      version               = "~> 5.0"
      configuration_aliases = [aws.primary]
    }
  }
}
