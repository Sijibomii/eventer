resource "google_compute_firewall" "allow_ssh_to_influx" {
  project = var.project
  name    = "allow-ssh-to-influx"
  network = google_compute_network.management.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
 
  source_tags = ["bastion", "jenkins-ssh", "jenkins-worker"]
}

resource "google_compute_firewall" "allow_access_to_db" {
  project = var.project
  name    = "allow-access-to-influx-db"
  network = google_compute_network.management.self_link

  allow {
    protocol = "tcp"
    ports    = ["8086"]
  }

  source_ranges = ["0.0.0.0/0"]

  source_tags = ["influx-db"]
}


// Jenkins workers startup script
data "template_file" "influx_db_startup_script" {
  template = "${file("scripts/init-influx.tpl")}"

  vars = {
    
  }
}

resource "google_compute_instance_template" "influx-db-template" {
  name_prefix = "influx-db"
  description = "Influx db indtances template"
  region       = var.region

  tags = ["influx-db"]
  machine_type         = var.influx_db_machine_type
  metadata_startup_script = data.template_file.influx_db_startup_script.rendered

  disk {
    source_image = var.influx_db_machine_image
    disk_size_gb = 30
  }

  network_interface {
    network = google_compute_network.management.self_link 
    subnetwork = google_compute_subnetwork.private_subnets[0].self_link 
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key)}"
  }
}

resource "google_compute_instance_group_manager" "influx-db-group" {
  provider = google-beta
  name = "influx-db"
  base_instance_name = "influx-db"
  zone               = var.zone

  depends_on = []

  version {
    instance_template  = google_compute_instance_template.influx-db-template.self_link
  }

  target_pools = [google_compute_target_pool.influx-db-pool.id]
  target_size = 1
}

resource "google_compute_target_pool" "influx-db-pool" {
  provider = google-beta
  name = "influx-db-pool"
}

resource "google_compute_autoscaler" "influx-db-pool-autoscaler" {
  name   = "influx-db-pool-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.influx-db-group.id

  autoscaling_policy {
    max_replicas    = 2
    min_replicas    = 1
    cooldown_period = 60

    cpu_utilization {
      target = 0.8
    }
  }
}