resource "google_compute_firewall" "allow_ssh_to_logstash" {
  project = var.project
  name    = "allow-ssh-to-logstash"
  network = google_compute_network.management.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["bastion", "logstash-ssh"]
}

resource "google_compute_firewall" "logstash_sg" {
  project = var.project
  name    = "logstash_sg"
  network = google_compute_network.management.self_link

  allow {
    protocol = "tcp"
    ports    = ["5000"]
  }

  source_ranges = ["0.0.0.0/0"]

  source_tags = ["logstash"]
}

resource "google_compute_instance" "logstash" {
  project      = var.project
  name         = "logstash"
  machine_type = var.logstash_machine_type
  zone         = var.zone

  tags = ["logstash", "logstash-ssh"]


  boot_disk {
    initialize_params {
      image = var.logstash_machine_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_subnets[0].self_link 
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
  }
}

resource "google_compute_target_pool" "logstash-target-pool" {
    name             = "logstash-target-pool"
    session_affinity = "NONE"
    region           = var.region
 
    instances = [
        google_compute_instance.logstash.self_link
    ]

    health_checks = [
        google_compute_http_health_check.logstash_health_check.name
    ]
}

resource "google_compute_http_health_check" "logstash_health_check" {
  name         = "logstash-health-check"
  request_path = "/"
  port = "5000"
  timeout_sec        = 4
  check_interval_sec = 5
}

resource "google_compute_forwarding_rule" "logstash_forwarding_rule" {
  name   = "logstash-forwarding-rule"
  region = var.region
  load_balancing_scheme = "EXTERNAL"
  target                = google_compute_target_pool.logstash-target-pool.self_link
  port_range            = "5000"
  ip_protocol           = "TCP"
}