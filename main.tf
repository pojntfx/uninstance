# Hetzner
provider "hcloud" {
  alias = "global"

  token = var.hetzner_api_key
}

module "hetzner_ssh_key" {
  source = "./modules/hetzner/ssh_key"
  providers = {
    hcloud.primary = hcloud.global
  }

  name       = "${var.prefix}-uninstance"
  public_key = file(var.ssh_public_key)
}

module "hetzner_servers" {
  source = "./modules/hetzner/server"
  providers = {
    hcloud.primary = hcloud.global
  }

  for_each = {
    alma_hetzner_1_hil = {
      name        = "${var.prefix}-alma-hetzner-1-hil"
      image       = "alma-9"
      server_type = "ccx23" # AMD Milan or Genoa
      location    = "hil"
      user_data   = file("${path.module}/cloud-init-alma-hetzner.yaml")
    }

    alma_hetzner_2_hil = {
      name        = "${var.prefix}-alma-hetzner-2-hil"
      image       = "alma-9"
      server_type = "ccx23" # AMD Milan or Genoa
      location    = "hil"
      user_data   = file("${path.module}/cloud-init-alma-hetzner.yaml")
    }

    alma_hetzner_3_hil = {
      name        = "${var.prefix}-alma-hetzner-3-hil"
      image       = "alma-9"
      server_type = "ccx23" # AMD Milan or Genoa
      location    = "hil"
      user_data   = file("${path.module}/cloud-init-alma-hetzner.yaml")
    }

    alma_hetzner_4_sin = {
      name        = "${var.prefix}-alma-hetzner-4-sin"
      image       = "alma-9"
      server_type = "ccx23" # AMD Milan or Genoa
      location    = "sin"
      user_data   = file("${path.module}/cloud-init-alma-hetzner.yaml")
    }

    alma_hetzner_5_sin = {
      name        = "${var.prefix}-alma-hetzner-5-sin"
      image       = "alma-9"
      server_type = "ccx23" # AMD Milan or Genoa
      location    = "sin"
      user_data   = file("${path.module}/cloud-init-alma-hetzner.yaml")
    }

    alma_hetzner_6_sin = {
      name        = "${var.prefix}-alma-hetzner-6-sin"
      image       = "alma-9"
      server_type = "ccx23" # AMD Milan or Genoa
      location    = "sin"
      user_data   = file("${path.module}/cloud-init-alma-hetzner.yaml")
    }
  }

  name          = each.value.name
  image         = each.value.image
  server_type   = each.value.server_type
  location      = each.value.location
  public_key_id = module.hetzner_ssh_key.id
  user_data     = each.value.user_data
}

locals {
  hetzner_servers = {
    global = module.hetzner_servers
  }
}

# AWS
provider "aws" {
  alias = "us_west_2"

  region     = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
}

provider "aws" {
  alias = "us_east_2"

  region     = "us-east-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  token      = var.aws_token
}

module "aws_ssh_key_us_west_2" {
  source = "./modules/aws/ssh_key"
  providers = {
    aws.primary = aws.us_west_2
  }

  name       = "${var.prefix}-uninstance"
  public_key = file(var.ssh_public_key)
}

module "aws_ssh_key_us_east_2" {
  source = "./modules/aws/ssh_key"
  providers = {
    aws.primary = aws.us_east_2
  }

  name       = "${var.prefix}-uninstance"
  public_key = file(var.ssh_public_key)
}

module "aws_servers_us_west_2" {
  source = "./modules/aws/server"
  providers = {
    aws.primary = aws.us_west_2
  }

  for_each = {
    alma_aws_1_us_west_2 = {
      name          = "${var.prefix}-alma-aws-1-us-west-2"
      ami_owner     = "679593333241"
      ami_name      = "AlmaLinux OS 9*x86_64*"
      instance_type = "c6a.xlarge" # AMD Milan
      user_data     = file("${path.module}/cloud-init-alma-aws.yaml")
    }

    alma_aws_2_us_west_2 = {
      name          = "${var.prefix}-alma-aws-2-us-west-2"
      ami_owner     = "679593333241"
      ami_name      = "AlmaLinux OS 9*x86_64*"
      instance_type = "c6a.xlarge" # AMD Milan
      user_data     = file("${path.module}/cloud-init-alma-aws.yaml")
    }

    alma_aws_3_us_west_2 = {
      name          = "${var.prefix}-alma-aws-3-us-west-2"
      ami_owner     = "679593333241"
      ami_name      = "AlmaLinux OS 9*x86_64*"
      instance_type = "c6a.xlarge" # AMD Milan
      user_data     = file("${path.module}/cloud-init-alma-aws.yaml")
    }
  }

  name            = each.value.name
  ami_owner       = each.value.ami_owner
  ami_name        = each.value.ami_name
  instance_type   = each.value.instance_type
  public_key_name = module.aws_ssh_key_us_west_2.name
  user_data       = each.value.user_data
}

module "aws_servers_us_east_2" {
  source = "./modules/aws/server"
  providers = {
    aws.primary = aws.us_east_2
  }

  for_each = {
    alma_aws_1_us_east_2 = {
      name          = "${var.prefix}-alma-aws-1-us-east-2"
      ami_owner     = "679593333241"
      ami_name      = "AlmaLinux OS 9*x86_64*"
      instance_type = "c6a.xlarge" # AMD Milan
      user_data     = file("${path.module}/cloud-init-alma-aws.yaml")
    }

    alma_aws_2_us_east_2 = {
      name          = "${var.prefix}-alma-aws-2-us-east-2"
      ami_owner     = "679593333241"
      ami_name      = "AlmaLinux OS 9*x86_64*"
      instance_type = "c6a.xlarge" # AMD Milan
      user_data     = file("${path.module}/cloud-init-alma-aws.yaml")
    }

    alma_aws_3_us_east_2 = {
      name          = "${var.prefix}-alma-aws-3-us-east-2"
      ami_owner     = "679593333241"
      ami_name      = "AlmaLinux OS 9*x86_64*"
      instance_type = "c6a.xlarge" # AMD Milan
      user_data     = file("${path.module}/cloud-init-alma-aws.yaml")
    }
  }

  name            = each.value.name
  ami_owner       = each.value.ami_owner
  ami_name        = each.value.ami_name
  instance_type   = each.value.instance_type
  public_key_name = module.aws_ssh_key_us_east_2.name
  user_data       = each.value.user_data
}

locals {
  aws_servers = {
    us_west_2 = module.aws_servers_us_west_2
    us_east_2 = module.aws_servers_us_east_2
  }
}

# Azure
provider "azurerm" {
  alias = "global"

  subscription_id = var.azure_subscription_id
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

module "azure_servers" {
  source = "./modules/azure/server"
  providers = {
    azurerm.primary = azurerm.global
  }

  for_each = {
    alma_azure_1_west_us = {
      name            = "${var.prefix}-alma-azure-1-west-us"
      image_publisher = "almalinux"
      image_offer     = "almalinux-x86_64"
      image_sku       = "9-gen2"
      image_version   = "latest"
      size            = "Standard_D4ads_v5" # AMD Milan
      location        = "West US"
      public_key      = file(var.ssh_public_key)
      user_data       = file("${path.module}/cloud-init-alma-azure.yaml")
    }

    alma_azure_2_west_us = {
      name            = "${var.prefix}-alma-azure-2-west-us"
      image_publisher = "almalinux"
      image_offer     = "almalinux-x86_64"
      image_sku       = "9-gen2"
      image_version   = "latest"
      size            = "Standard_D4ads_v5" # AMD Milan
      location        = "West US"
      public_key      = file(var.ssh_public_key)
      user_data       = file("${path.module}/cloud-init-alma-azure.yaml")
    }

    alma_azure_3_west_us = {
      name            = "${var.prefix}-alma-azure-3-west-us"
      image_publisher = "almalinux"
      image_offer     = "almalinux-x86_64"
      image_sku       = "9-gen2"
      image_version   = "latest"
      size            = "Standard_D4ads_v5" # AMD Milan
      location        = "West US"
      public_key      = file(var.ssh_public_key)
      user_data       = file("${path.module}/cloud-init-alma-azure.yaml")
    }

    alma_azure_1_central_us = {
      name            = "${var.prefix}-alma-azure-1-central-us"
      image_publisher = "almalinux"
      image_offer     = "almalinux-x86_64"
      image_sku       = "9-gen2"
      image_version   = "latest"
      size            = "Standard_D4ads_v5" # AMD Milan
      location        = "Central US"
      public_key      = file(var.ssh_public_key)
      user_data       = file("${path.module}/cloud-init-alma-azure.yaml")
    }

    alma_azure_2_central_us = {
      name            = "${var.prefix}-alma-azure-2-central-us"
      image_publisher = "almalinux"
      image_offer     = "almalinux-x86_64"
      image_sku       = "9-gen2"
      image_version   = "latest"
      size            = "Standard_D4ads_v5" # AMD Milan
      location        = "Central US"
      public_key      = file(var.ssh_public_key)
      user_data       = file("${path.module}/cloud-init-alma-azure.yaml")
    }

    alma_azure_3_central_us = {
      name            = "${var.prefix}-alma-azure-3-central-us"
      image_publisher = "almalinux"
      image_offer     = "almalinux-x86_64"
      image_sku       = "9-gen2"
      image_version   = "latest"
      size            = "Standard_D4ads_v5" # AMD Milan
      location        = "Central US"
      public_key      = file(var.ssh_public_key)
      user_data       = file("${path.module}/cloud-init-alma-azure.yaml")
    }
  }

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

locals {
  azure_servers = {
    global = module.azure_servers
  }
}

# GCP
provider "google" {
  alias = "global"

  project = var.gcp_project_id
}

module "gcp_servers" {
  source = "./modules/gcp/server"
  providers = {
    google.primary = google.global
  }

  for_each = {
    alma_gcp_1_us_west1_a = {
      name         = "${var.prefix}-alma-gcp-1-us-west1-a"
      image        = "projects/almalinux-cloud/global/images/almalinux-9-v20221206"
      machine_type = "t2d-standard-4" # AMD Genoa
      disk_size    = 50
      region       = "us-west1"
      zone         = "us-west1-a"
      public_key   = file(var.ssh_public_key)
      user_data    = file("${path.module}/cloud-init-alma-gcp.yaml")
    }

    alma_gcp_2_us_west1_a = {
      name         = "${var.prefix}-alma-gcp-2-us-west1-a"
      image        = "projects/almalinux-cloud/global/images/almalinux-9-v20221206"
      machine_type = "t2d-standard-4" # AMD Genoa
      disk_size    = 50
      region       = "us-west1"
      zone         = "us-west1-a"
      public_key   = file(var.ssh_public_key)
      user_data    = file("${path.module}/cloud-init-alma-gcp.yaml")
    }

    alma_gcp_3_us_east4_b = {
      name         = "${var.prefix}-alma-gcp-3-us-east4-b"
      image        = "projects/almalinux-cloud/global/images/almalinux-9-v20221206"
      machine_type = "t2d-standard-4" # AMD Genoa
      disk_size    = 50
      region       = "us-east4"
      zone         = "us-east4-b"
      public_key   = file(var.ssh_public_key)
      user_data    = file("${path.module}/cloud-init-alma-gcp.yaml")
    }

    alma_gcp_4_us_east4_b = {
      name         = "${var.prefix}-alma-gcp-4-us-east4-b"
      image        = "projects/almalinux-cloud/global/images/almalinux-9-v20221206"
      machine_type = "t2d-standard-4" # AMD Genoa
      disk_size    = 50
      region       = "us-east4"
      zone         = "us-east4-b"
      public_key   = file(var.ssh_public_key)
      user_data    = file("${path.module}/cloud-init-alma-gcp.yaml")
    }

    alma_gcp_5_us_ctl1_b = {
      name         = "${var.prefix}-alma-gcp-5-us-ctl1-b"
      image        = "projects/almalinux-cloud/global/images/almalinux-9-v20221206"
      machine_type = "t2d-standard-4" # AMD Genoa
      disk_size    = 50
      region       = "us-central1"
      zone         = "us-central1-b"
      public_key   = file(var.ssh_public_key)
      user_data    = file("${path.module}/cloud-init-alma-gcp.yaml")
    }

    alma_gcp_6_us_ctl1_b = {
      name         = "${var.prefix}-alma-gcp-6-us-ctl1-b"
      image        = "projects/almalinux-cloud/global/images/almalinux-9-v20221206"
      machine_type = "t2d-standard-4" # AMD Genoa
      disk_size    = 50
      region       = "us-central1"
      zone         = "us-central1-b"
      public_key   = file(var.ssh_public_key)
      user_data    = file("${path.module}/cloud-init-alma-gcp.yaml")
    }
  }

  name         = each.value.name
  image        = each.value.image
  machine_type = each.value.machine_type
  disk_size    = each.value.disk_size
  region       = each.value.region
  zone         = each.value.zone
  public_key   = each.value.public_key
  user_data    = each.value.user_data
}

locals {
  gcp_servers = {
    global = module.gcp_servers
  }
}
