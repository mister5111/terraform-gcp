resource "google_compute_network" "global" {
  name                    = format("%s-global", var.env)
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_firewall" "allow-internal" {
  name    = format("%s-fw-allow-internal", var.env)
  network = google_compute_network.global.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [var.internal_cidr[0], var.internal_cidr[1]]
}

resource "google_compute_firewall" "allow-http" {
  name    = format("%s-fw-allow-http", var.env)
  network = google_compute_network.global.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http"] 

  source_ranges = [var.external_cidr]
}

resource "google_compute_firewall" "allow-https" {
  name    = format("%s-fw-allow-https", var.env)
  network = google_compute_network.global.name
  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_tags = ["https"] 

  source_ranges = [var.external_cidr]
}

resource "google_compute_firewall" "allow-icmp" {
  name    = format("%s-fw-allow-icmp", var.env)
  network = google_compute_network.global.name
  allow {
    protocol = "icmp"
  }
  target_tags = ["icmp"] 

  source_ranges = [var.external_cidr]
}

resource "google_compute_firewall" "allow-ssh" {
  name    = format("%s-fw-allow-ssh", var.env)
  network = google_compute_network.global.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]

  source_ranges = [var.external_cidr]  
}

