# Hetzner
module "hetzner_ssh_key" {
  source = "./modules/hetzner/ssh_key"
  providers = {
    hcloud.primary = hcloud.primary
  }

  name       = local.hetzner.ssh_key.name
  public_key = local.hetzner.ssh_key.public_key
}


module "hetzner_servers" {
  source = "./modules/hetzner/server"
  providers = {
    hcloud.primary = hcloud.primary
  }

  for_each = local.hetzner.servers

  name          = each.value.name
  image         = each.value.image
  server_type   = each.value.server_type
  location      = each.value.location
  public_key_id = module.hetzner_ssh_key.id
  user_data     = each.value.user_data
}
