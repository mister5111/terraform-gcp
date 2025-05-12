resource "google_compute_subnetwork" "default" {
  name          = format("%s-%s-subnet", var.company, var.env)
  ip_cidr_range = var.internal_cidr[0]
  region        = "europe-west3"
  network       = var.network_global
}