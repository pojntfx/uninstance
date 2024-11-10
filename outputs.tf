# Hetzner
output "hetzner_servers" {
  value = {
    for key, module_instance in module.hetzner_servers : key => {
      user         = "root"
      ipv4_address = module_instance.ipv4_address
      ipv6_address = module_instance.ipv6_address
    }
  }
}

# AWS
output "aws_servers" {
  value = {
    for key, module_instance in module.aws_servers : key => {
      user         = "ec2-user"
      ipv4_address = module_instance.ipv4_address
      ipv6_address = module_instance.ipv6_address
    }
  }
}
