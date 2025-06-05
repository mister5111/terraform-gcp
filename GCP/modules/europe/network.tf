resource "google_compute_subnetwork" "default-1" {
  name          = format("%s-subnet-%s", var.env, var.zone_names[1])
  ip_cidr_range = var.internal_cidr[1]
  region        = format("%s", var.zone_names[1])
  network       = var.network_global
}

resource "google_compute_subnetwork" "default-2" {
  name          = format("%s-subnet-%s", var.env, var.zone_names[3])
  ip_cidr_range = var.internal_cidr[2]
  region        = format("%s", var.zone_names[3])  
  network       = var.network_global
}

resource "google_compute_subnetwork" "default-3" {
  name          = format("%s-subnet-%s", var.env, var.zone_names[0])
  ip_cidr_range = var.internal_cidr[4]
  region        = format("%s", var.zone_names[0])  
  network       = var.network_global
}