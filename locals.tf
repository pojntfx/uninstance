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
        user_data   = file("${path.module}/cloud-init-alma-hetzner.yaml")
        location    = "hil"
      }

      alma_hetzner_pvm_node_2_ash = {
        name        = "alma-hetzner-pvm-node-2-ash"
        image       = "alma-9"
        server_type = "ccx23" # AMD Milan or Genoa
        user_data   = file("${path.module}/cloud-init-alma-hetzner.yaml")
        location    = "ash"
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
}
