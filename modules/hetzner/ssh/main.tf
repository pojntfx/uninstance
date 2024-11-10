resource "hcloud_ssh_key" "this" {
  name     = var.name
  provider = hcloud.primary

  public_key = var.public_key
}
