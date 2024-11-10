# Hetzner
output "hetzner_servers" {
  value = {
    for key, module_instances in local.hetzner_servers : key => {
      for key, module_instance in module_instances : key => {
        user         = module_instance.user
        ipv4_address = module_instance.ipv4_address
        ipv6_address = module_instance.ipv6_address
      }
    }
  }
}

# AWS
output "aws_servers" {
  value = {
    for key, module_instances in local.aws_servers : key => {
      for key, module_instance in module_instances : key => {
        user         = module_instance.user
        ipv4_address = module_instance.ipv4_address
        ipv6_address = module_instance.ipv6_address
      }
    }
  }
}

# Azure
output "azure_servers" {
  value = {
    for key, module_instances in local.azure_servers : key => {
      for key, module_instance in module_instances : key => {
        user         = module_instance.user
        ipv4_address = module_instance.ipv4_address
        ipv6_address = module_instance.ipv6_address
      }
    }
  }
}

# GCP
output "gcp_servers" {
  value = {
    for key, module_instances in local.gcp_servers : key => {
      for key, module_instance in module_instances : key => {
        user         = module_instance.user
        ipv4_address = module_instance.ipv4_address
        ipv6_address = module_instance.ipv6_address
      }
    }
  }
}
