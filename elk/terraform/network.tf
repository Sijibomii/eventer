resource "google_compute_network" "elk-management" {
  name = var.network_name
  auto_create_subnetworks = false
  routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "elk-public_subnets" {
  count = var.elk-public_subnets_count
  name          = "public-10-1-${count.index * 2 + 1}-0"
  ip_cidr_range = "10.1.${count.index * 2 + 1}.0/24"
  region        = var.region
  network       = google_compute_network.elk-management.self_link
}

resource "google_compute_subnetwork" "elk-private_subnets" {
  count = var.elk-private_subnets_count
  name          = "private-10-1-${count.index * 2}-0"
  ip_cidr_range = "10.1.${count.index * 2}.0/24"
  region        = var.region
  network       = google_compute_network.elk-management.self_link
  private_ip_google_access = true
}

resource "google_compute_router" "elk-private_router" {
  name    = "private-router-${var.network_name}"
  region  = var.region
  network = google_compute_network.elk-management.self_link
}

resource "google_compute_router_nat" "elk-nat" {
  name                               = "nat-${var.network_name}"
  router                             = google_compute_router.elk-private_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
      name = google_compute_subnetwork.elk-private_subnets[0].self_link 
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  subnetwork {
      name = google_compute_subnetwork.elk-private_subnets[1].self_link 
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}