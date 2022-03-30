resource "google_compute_firewall" "allow_ssh_to_elasticsearch" {
  project = var.project
  name    = "allow-ssh-to-elasticsearch"
  network = google_compute_network.management.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["bastion", "elasticsearch-ssh"]
}

resource "google_compute_firewall" "elasticsearch_sg" {
  project = var.project
  name    = "elasticsearch_sg"
  network = google_compute_network.management.self_link

  allow {
    protocol = "tcp"
    ports    = ["9200"]
  }

  source_ranges = ["0.0.0.0/0"]

  source_tags = ["elasticseach"]
}

resource "google_compute_instance" "elasticsearch" {
  project      = var.project
  name         = "elasticsearch"
  machine_type = var.elastic_search_machine_type
  zone         = var.zone

  tags = ["elasticsearch", "elasticsearch-ssh"]


  boot_disk {
    initialize_params {
      image = var.elastic_search_machine_image
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.private_subnets[0].self_link 
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
  }
}

resource "google_compute_target_pool" "elasticsearch-target-pool" {
    name             = "elasticsearch-target-pool"
    session_affinity = "NONE"
    region           = var.region
 
    instances = [
        google_compute_instance.elasticsearch.self_link
    ]

    health_checks = [
        google_compute_http_health_check.elasticsearch_health_check.name
    ]
}

resource "google_compute_http_health_check" "elasticsearch_health_check" {
  name         = "elasticsearch-health-check"
  request_path = "/"
  port = "9200"
  timeout_sec        = 4
  check_interval_sec = 5
}

resource "google_compute_forwarding_rule" "elasticsearch_forwarding_rule" {
  name   = "elasticsearch-forwarding-rule"
  region = var.region
  load_balancing_scheme = "EXTERNAL"
  target                = google_compute_target_pool.elasticsearch-target-pool.self_link
  port_range            = "9200"
  ip_protocol           = "TCP"
}