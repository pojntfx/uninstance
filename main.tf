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

# AWS
module "aws_ssh_key" {
  source = "./modules/aws/ssh_key"
  providers = {
    aws.primary = aws.primary
  }

  name       = local.aws.ssh_key.name
  public_key = local.aws.ssh_key.public_key
}

module "aws_servers" {
  source = "./modules/aws/server"
  providers = {
    aws.primary = aws.primary
  }

  for_each = local.aws.servers

  name            = each.value.name
  ami_owner       = each.value.ami_owner
  ami_name        = each.value.ami_name
  instance_type   = each.value.instance_type
  public_key_name = module.aws_ssh_key.name
  user_data       = each.value.user_data
}

# Azure
module "azure_servers" {
  source = "./modules/azure/server"
  providers = {
    azurerm.primary = azurerm.primary
  }

  for_each = local.azure.servers

  name            = each.value.name
  image_publisher = each.value.image_publisher
  image_offer     = each.value.image_offer
  image_sku       = each.value.image_sku
  image_version   = each.value.image_version
  size            = each.value.size
  location        = each.value.location
  public_key      = each.value.public_key
  user_data       = each.value.user_data
}

# GCP
module "gcp_servers" {
  source = "./modules/gcp/server"
  providers = {
    google.primary = google.primary
  }

  for_each = local.gcp.servers

  name         = each.value.name
  image        = each.value.image
  machine_type = each.value.machine_type
  disk_size    = each.value.disk_size
  public_key   = each.value.public_key
  user_data    = each.value.user_data
}
