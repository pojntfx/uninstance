# Hetzner
locals {
  hetzner_servers = {
    alma_hetzner_pvm_node_1_hil = {
      name        = "alma-hetzner-pvm-node-1-ash"
      image       = "alma-9"
      server_type = "ccx23" # AMD Milan or Genoa
      user_data   = file("cloud-init-alma-hetzner.yaml")
      location    = "hil"
    }

    alma_hetzner_pvm_node_2_ash = {
      name        = "alma-hetzner-pvm-node-2-ash"
      image       = "alma-9"
      server_type = "ccx23" # AMD Milan or Genoa
      user_data   = file("cloud-init-alma-hetzner.yaml")
      location    = "ash"
    }
  }
}
