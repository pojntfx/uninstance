# Hetzner
module "hetzner_ssh" {
  source = "./modules/hetzner/ssh"
  providers = {
    hcloud.primary = hcloud.primary
  }

  name       = "uninstance-ssh-public-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

module "hetzner_network" {
  source = "./modules/hetzner/network"
  providers = {
    hcloud.primary = hcloud.primary
  }

  name = "uninstance-firewall"
}

module "hetzner_servers" {
  source = "./modules/hetzner/server"
  providers = {
    hcloud.primary = hcloud.primary
  }

  for_each = local.hetzner_servers

  name        = each.value.name
  image       = each.value.image
  server_type = each.value.server_type
  location    = each.value.location
  user_data   = each.value.user_data

  ssh_key_ids  = [module.hetzner_ssh.id]
  firewall_ids = [module.hetzner_network.id]
}
