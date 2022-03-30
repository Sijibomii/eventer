resource "google_compute_firewall" "elk_allow_ssl_to_bastion" {
  project = var.project
  name    = "elk-allow-ssl-to-bastion"
  network = google_compute_network.elk-management.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  source_tags = ["bastion"]
}

resource "google_compute_address" "elk-static" {
  name = "elk-ipv4-address"
}

resource "google_compute_instance" "elk-bastion" {
  project      = var.project
  name         = "elk-bastion"
  machine_type = var.bastion_machine_type
  zone         = var.zone

  tags = ["bastion"]

  boot_disk {
    initialize_params {
      image = var.bastion_machine_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.elk-public_subnets[0].self_link 

    access_config {
      nat_ip = google_compute_address.elk-static.address
    }
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
  }
}