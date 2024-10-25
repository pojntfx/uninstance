resource "equinix_metal_ssh_key" "uninstance" {
  name       = "uninstance-ssh-public-key"
  public_key = file(var.ssh_public_key)
}

resource "equinix_metal_device" "alma_equinix_pvm_node_1" {
  hostname         = "alma-equinix-pvm-node-1"
  plan             = "m3.small.x86"
  metro            = var.equinix_metro
  operating_system = "alma_9"
  billing_cycle    = "hourly"
  project_id       = var.equinix_project_id

  user_data  = file("cloud-init-alma-equinix.yaml")
  depends_on = [equinix_metal_ssh_key.uninstance]

  ip_address {
    type = "public_ipv4"
  }

  ip_address {
    type = "private_ipv4"
  }

  ip_address {
    type = "public_ipv6"
  }
}
