resource "google_container_cluster" "api_service" {
  count                    =  var.counts ? 1 : 0
  name                     = format("%s-k8s-api-service", var.env)
  location                 = format("%s-a",var.zone_names[1])
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection      = false
}

resource "google_container_node_pool" "api_service_nodes" {
  count                   =  var.counts ? 1 : 0
  depends_on              = [google_container_cluster.api_service]
  name                    = format("%s-k8s-node-pool-api-service", var.env)
  location                = google_container_cluster.api_service[0].location
  cluster                 = google_container_cluster.api_service[0].name
 
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
  count    =  var.counts ? 1 : 0
  name     = google_container_cluster.api_service[0].name
  location = google_container_cluster.api_service[0].location
}

provider "kubernetes" {
  host                   = try("https://${google_container_cluster.api_service[0].endpoint}", "")
  cluster_ca_certificate = try(base64decode(google_container_cluster.api_service[0].master_auth[0].cluster_ca_certificate), "")
  token                  = try(data.google_client_config.default.access_token, "")
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    host                   = try("https://${google_container_cluster.api_service[0].endpoint}", "")
    cluster_ca_certificate = try(base64decode(google_container_cluster.api_service[0].master_auth[0].cluster_ca_certificate), "")
    token                  = try(data.google_client_config.default.access_token, "")
    config_path = "~/.kube/config"
  }
}