resource "hcloud_ssh_key" "this" {
  provider = hcloud.primary
  name     = var.name

  public_key = var.public_key
}
