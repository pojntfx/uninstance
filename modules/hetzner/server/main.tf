resource "hcloud_firewall" "this" {
  provider = hcloud.primary
  name     = "${var.name}-firewall"

  rule {
    direction  = "in"
    protocol   = "tcp"
    port       = "any"
    source_ips = ["0.0.0.0/0", "::/0"]
  }

  rule {
    direction  = "in"
    protocol   = "udp"
    port       = "any"
    source_ips = ["0.0.0.0/0", "::/0"]
  }
}

resource "hcloud_server" "this" {
  provider = hcloud.primary
  name     = var.name
  location = var.location

  image       = var.image
  server_type = var.server_type
  user_data   = var.user_data

  ssh_keys     = [var.public_key_id]
  firewall_ids = [hcloud_firewall.this.id]
}
