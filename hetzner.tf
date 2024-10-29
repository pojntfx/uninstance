resource "hcloud_ssh_key" "uninstance" {
  name       = "uninstance-ssh-public-key"
  public_key = file(var.ssh_public_key)
}

resource "hcloud_firewall" "uninstance" {
  name = "uninstance-firewall"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "any"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "udp"
    port      = "any"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_server" "alma_hetzner_pvm_node_1" {
  name        = "alma-hetzner-pvm-node-1"
  image       = "alma-9"
  server_type = var.hetzner_server_type
  location    = var.hetzner_location

  user_data    = file("cloud-init-alma-hetzner.yaml")
  ssh_keys     = [hcloud_ssh_key.uninstance.id]
  firewall_ids = [hcloud_firewall.uninstance.id]
}
