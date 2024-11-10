resource "hcloud_firewall" "this" {
  name = var.name
  provider = hcloud.primary

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
