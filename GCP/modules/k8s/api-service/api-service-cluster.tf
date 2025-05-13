resource "google_container_cluster" "api_service" {
  name                     = format("%s-%s-cluster-api-service", var.company, var.env)
  location                 = format("%s-a",var.zone_names[1])
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false
}

resource "google_container_node_pool" "api_service_nodes" {
  depends_on              = [google_container_cluster.api_service]
  name                    = format("%s-%s-primary-node-pool-api-service", var.company, var.env)
  location                = google_container_cluster.api_service.location
  cluster                 = google_container_cluster.api_service.name
 
  node_config {
    machine_type          = var.type_machine[2]
    disk_type             = "pd-standard"
    disk_size_gb          = 20
    tags                  = ["http"]
  }

  initial_node_count      = 2
}

data "google_client_config" "default" {}

data "google_container_cluster" "api_service" {
  name     = google_container_cluster.api_service.name
  location = google_container_cluster.api_service.location
}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.api_service.endpoint}"
  cluster_ca_certificate = base64decode(google_container_cluster.api_service.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  kubernetes {
    host                   = "https://${google_container_cluster.api_service.endpoint}"
    cluster_ca_certificate = base64decode(google_container_cluster.api_service.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}
