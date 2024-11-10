resource "google_compute_network" "this" {
  provider = google.primary
  name     = "${var.name}-network"

  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "this" {
  provider = google.primary
  name     = "${var.name}-subnetwork"
  region   = var.region

  network          = google_compute_network.this.self_link
  ip_cidr_range    = "10.2.0.0/24"
  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "EXTERNAL"
}

resource "google_compute_firewall" "this_allow_all_tcp_ipv4" {
  provider = google.primary
  name     = "${var.name}-firewall-allow-all-tcp-ipv4"

  network = google_compute_network.this.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  priority      = 1000

  target_tags = ["${var.name}-firewall-tag"]
}

resource "google_compute_firewall" "this_allow_all_udp_ipv4" {
  provider = google.primary
  name     = "${var.name}-firewall-allow-all-udp-ipv4"

  network = google_compute_network.this.name

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["0.0.0.0/0"]
  direction     = "INGRESS"
  priority      = 1000

  target_tags = ["${var.name}-firewall-tag"]
}

resource "google_compute_firewall" "this_allow_all_tcp_ipv6" {
  provider = google.primary
  name     = "${var.name}-firewall-allow-all-tcp-ipv6"

  network = google_compute_network.this.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  source_ranges = ["::/0"]
  direction     = "INGRESS"
  priority      = 1000

  target_tags = ["${var.name}-firewall-tag"]
}

resource "google_compute_firewall" "this_allow_all_udp_ipv6" {
  provider = google.primary
  name     = "${var.name}-firewall-allow-all-udp-ipv6"

  network = google_compute_network.this.name

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["::/0"]
  direction     = "INGRESS"
  priority      = 1000

  target_tags = ["${var.name}-firewall-tag"]
}

resource "google_compute_address" "ipv4_address" {
  provider = google.primary
  name     = "${var.name}-ipv4-address"
  region   = var.region

  address_type = "EXTERNAL"
  ip_version   = "IPV4"
}

resource "google_compute_address" "ipv6_address" {
  provider = google.primary
  name     = "${var.name}-ipv6-address"
  region   = var.region

  address_type       = "EXTERNAL"
  ip_version         = "IPV6"
  ipv6_endpoint_type = "VM"
  subnetwork         = google_compute_subnetwork.this.self_link
}

resource "google_service_account" "this" {
  provider = google.primary

  account_id = var.name # This has to be between 6 and 30 characters long, so we don't add a suffix
}

resource "google_compute_instance" "this" {
  provider = google.primary
  name     = var.name
  zone     = var.zone

  machine_type              = var.machine_type
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }

  network_interface {
    stack_type = "IPV4_IPV6"
    network    = google_compute_network.this.self_link
    subnetwork = google_compute_subnetwork.this.self_link

    access_config {
      nat_ip       = google_compute_address.ipv4_address.address
      network_tier = "PREMIUM"
    }

    ipv6_access_config {
      name                        = "${var.name}-ipv6-access-config"
      external_ipv6               = google_compute_address.ipv6_address.address
      external_ipv6_prefix_length = 96
      network_tier                = "PREMIUM"
    }
  }

  metadata_startup_script = <<EOT
#!/bin/bash

command -v cloud-init || (dnf install -y cloud-init && reboot)
EOT


  metadata = {
    "ssh-keys"  = "gcp-user:${var.public_key}"
    "user-data" = var.user_data
  }

  service_account {
    email  = google_service_account.this.email
    scopes = ["cloud-platform"]
  }

  tags = ["${var.name}-firewall-tag"]
}

