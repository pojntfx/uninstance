resource "google_compute_network" "uninstance" {
  name                    = "uninstance-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "uninstance" {
  name             = "uninstance-subnetwork"
  network          = google_compute_network.uninstance.self_link
  ip_cidr_range    = "10.2.0.0/24"
  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "EXTERNAL"
}

resource "google_compute_firewall" "uninstance_allow_all_tcp_ipv4" {
  name    = "allow-all-tcp-ipv4"
  network = google_compute_network.uninstance.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  priority      = 1000

  target_tags = ["uninstance"]
}

resource "google_compute_firewall" "uninstance_allow_all_udp_ipv4" {
  name    = "allow-all-udp-ipv4"
  network = google_compute_network.uninstance.name

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  priority      = 1000

  target_tags = ["uninstance"]
}

resource "google_compute_firewall" "uninstance_allow_all_tcp_ipv6" {
  name    = "allow-all-tcp-ipv6"
  network = google_compute_network.uninstance.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["::/0"]
  direction     = "INGRESS"
  priority      = 1000

  target_tags = ["uninstance"]
}

resource "google_compute_firewall" "uninstance_allow_all_udp_ipv6" {
  name    = "allow-all-udp-ipv6"
  network = google_compute_network.uninstance.name

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["::/0"]
  direction     = "INGRESS"
  priority      = 1000

  target_tags = ["uninstance"]
}

resource "google_compute_address" "alma_gcp_pvm_node_1_ip_ipv4" {
  name         = "alma-gcp-pvm-node-1-ip-ipv4"
  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}

resource "google_compute_address" "alma_gcp_pvm_node_1_ip_ipv6" {
  name               = "alma-gcp-pvm-node-1-ip-ipv6"
  address_type       = "EXTERNAL"
  ip_version         = "IPV6"
  ipv6_endpoint_type = "VM"
  subnetwork         = google_compute_subnetwork.uninstance.self_link
}

resource "google_service_account" "uninstance" {
  account_id = "uninstance"
}

resource "google_compute_instance" "alma_gcp_pvm_node_1" {
  name                      = "alma-gcp-pvm-node-1"
  machine_type              = var.gcp_machine_type
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "projects/almalinux-cloud/global/images/almalinux-9-v20221206"
      size  = 50
    }
  }

  network_interface {
    stack_type = "IPV4_IPV6"
    network    = google_compute_network.uninstance.self_link
    subnetwork = google_compute_subnetwork.uninstance.self_link

    access_config {
      nat_ip       = google_compute_address.alma_gcp_pvm_node_1_ip_ipv4.address
      network_tier = "PREMIUM"
    }

    ipv6_access_config {
      name                        = "alma-gcp-pvm-node-1-ip-ipv6"
      external_ipv6               = google_compute_address.alma_gcp_pvm_node_1_ip_ipv6.address
      external_ipv6_prefix_length = 96
      network_tier                = "PREMIUM"
    }
  }

  metadata_startup_script = <<EOT
#!/bin/bash

command -v cloud-init || (dnf install -y cloud-init && reboot)
EOT


  metadata = {
    "ssh-keys"  = "pojntfx:${file(var.ssh_public_key)}"
    "user-data" = file("cloud-init-alma-gcp.yaml")
  }

  service_account {
    email  = google_service_account.uninstance.email
    scopes = ["cloud-platform"]
  }

  tags = ["uninstance"]
}
