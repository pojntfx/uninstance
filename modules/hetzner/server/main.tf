resource "hcloud_server" "this" {
  name     = var.name
  provider = hcloud.primary

  image       = var.image
  server_type = var.server_type
  location    = var.location
  user_data   = var.user_data

  ssh_keys     = var.ssh_key_ids
  firewall_ids = var.firewall_ids
}
