locals {
  # Hetzner
  hetzner = {
    ssh_key = {
      name       = "uninstance"
      public_key = file(var.ssh_public_key)
    }

    servers = {
      alma_hetzner_pvm_node_1_hil = {
        name        = "alma-hetzner-pvm-node-1-ash"
        image       = "alma-9"
        server_type = "ccx23" # AMD Milan or Genoa
        location    = "hil"
        user_data   = file("${path.module}/cloud-init-alma-hetzner.yaml")
      }

      alma_hetzner_pvm_node_2_ash = {
        name        = "alma-hetzner-pvm-node-2-ash"
        image       = "alma-9"
        server_type = "ccx23" # AMD Milan or Genoa
        location    = "ash"
        user_data   = file("${path.module}/cloud-init-alma-hetzner.yaml")
      }
    }
  }

  # AWS
  aws = {
    ssh_key = {
      name       = "uninstance"
      public_key = file(var.ssh_public_key)
    }

    servers = {
      alma_aws_pvm_node_1_us_west_2 = {
        name          = "alma-aws-pvm-node-1-us-west-2"
        ami_owner     = "679593333241"
        ami_name      = "AlmaLinux OS 9*x86_64*"
        instance_type = "c6a.xlarge" # AMD Milan
        user_data     = file("${path.module}/cloud-init-alma-aws.yaml")
      }

      alma_aws_pvm_node_2_us_west_2 = {
        name          = "alma-aws-pvm-node-2-us-west-2"
        ami_owner     = "679593333241"
        ami_name      = "AlmaLinux OS 9*x86_64*"
        instance_type = "c6a.xlarge" # AMD Milan
        user_data     = file("${path.module}/cloud-init-alma-aws.yaml")
      }
    }
  }

  # Azure
  azure = {
    servers = {
      alma_azure_pvm_node_1_west_us = {
        name            = "alma-azure-pvm-node-1-west-us"
        image_publisher = "almalinux"
        image_offer     = "almalinux-x86_64"
        image_sku       = "9-gen2"
        image_version   = "latest"
        size            = "Standard_D4ads_v5" # AMD Milan
        location        = "West US"
        public_key      = file(var.ssh_public_key)
        user_data       = file("${path.module}/cloud-init-alma-azure.yaml")
      }

      alma_azure_pvm_node_2_west_us = {
        name            = "alma-azure-pvm-node-2-west-us"
        image_publisher = "almalinux"
        image_offer     = "almalinux-x86_64"
        image_sku       = "9-gen2"
        image_version   = "latest"
        size            = "Standard_D4ads_v5" # AMD Milan
        location        = "West US"
        public_key      = file(var.ssh_public_key)
        user_data       = file("${path.module}/cloud-init-alma-azure.yaml")
      }
    }
  }

  # GCP
  gcp = {
    servers = {
      alma_gcp_pvm_node_1_us-west1-a = {
        name         = "alma-gcp-pvm-node-1-us-west1-a"
        image        = "projects/almalinux-cloud/global/images/almalinux-9-v20221206"
        machine_type = "t2d-standard-4" # AMD Genoa
        disk_size    = 50
        region       = "us-west1"
        zone         = "us-west1-a"
        public_key   = file(var.ssh_public_key)
        user_data    = file("${path.module}/cloud-init-alma-gcp.yaml")
      }

      alma_gcp_pvm_node_2_us-east1-b = {
        name         = "alma-gcp-pvm-node-2-us-east1-b"
        image        = "projects/almalinux-cloud/global/images/almalinux-9-v20221206"
        machine_type = "t2d-standard-4" # AMD Genoa
        disk_size    = 50
        region       = "us-east1"
        zone         = "us-east1-b"
        public_key   = file(var.ssh_public_key)
        user_data    = file("${path.module}/cloud-init-alma-gcp.yaml")
      }
    }
  }
}
