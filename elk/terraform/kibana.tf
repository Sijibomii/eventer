resource "google_compute_firewall" "allow_ssh_to_kibana" {
  project = var.project
  name    = "allow-ssh-to-kibana"
  network = google_compute_network.elk-management.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["bastion", "kibana-ssh"]
}

resource "google_compute_firewall" "allow_traffic_into_kibana" { 
  project = var.project
  name    = "allow-traffic-into-kibana"
  network = google_compute_network.elk-management.self_link

  allow {
    protocol = "tcp"
    ports    = ["5601"]
  }

  source_ranges = ["0.0.0.0/0"]

  source_tags = ["kibana"]
}

resource "google_compute_instance" "kibana" {
  project      = var.project
  name         = "kibana"
  machine_type = var.kibana_machine_type
  zone         = var.zone

  tags = ["kibana", "kibana-ssh"]


  boot_disk {
    initialize_params {
      image = var.kibana_machine_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.elk-private_subnets[0].self_link 
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
  }
}

resource "google_compute_target_pool" "kibana-target-pool" {
    name             = "kibana-target-pool"
    session_affinity = "NONE"
    region           = var.region
 
    instances = [
        google_compute_instance.kibana.self_link
    ]

    health_checks = [
        google_compute_http_health_check.kibana_health_check.name
    ]
}

resource "google_compute_http_health_check" "kibana_health_check" {
  name         = "kibana-health-check"
  request_path = "/"
  port = "5601"
  timeout_sec        = 4
  check_interval_sec = 5
}

resource "google_compute_forwarding_rule" "kibana_forwarding_rule" {
  name   = "kibana-forwarding-rule"
  region = var.region
  load_balancing_scheme = "EXTERNAL"
  target                = google_compute_target_pool.kibana-target-pool.self_link
  port_range            = "5601"
  ip_protocol           = "TCP"
}