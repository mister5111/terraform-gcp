provider "google" {
  project = var.project
}

terraform {
  backend "gcs" {
    bucket  = "kodi-terraform-state-bucket"
    prefix  = "terraform/state"
  }
}

module "global" {
  source            = "../modules/global" 
  env               = "${terraform.workspace}"
  external_cidr     = var.public_subnet
  internal_cidr     = var.private_subnet
}

module "europe" {
  source                = "../modules/europe"
  internal_cidr         = var.private_subnet
  network_global        = module.global.global_firewall_name
  env                   = "${terraform.workspace}"
  zone_names            = var.zone_list_europe
  name_and_zone         = local.create_instances_for_each
  type_machine          = local.selected_machine_type
  counts                = local.create_instances_count
}

module "k8s_api_service" {
  source                = "../modules/k8s/api-service"
  internal_cidr         = var.private_subnet_k8s
  network_global        = module.global.global_firewall_name
  env                   = "${terraform.workspace}"
  zone_names            = var.zone_list_europe
  type_machine          = var.machine_type_list_europe
  project               = var.project
  counts                = local.create_k8s_count
}

module "postgreSQL" {
  source                = "../modules/cloud-sql/postgreSQL"
  env                   = "${terraform.workspace}"
  zone_names            = var.zone_list_europe
}

output "global" {
  value = module.global
}

output "europe_module_outputs" {
  value = module.europe
}

output "k8s_api_service" {
  value = module.k8s_api_service
}

output "postgreSQL" {
  value = module.postgreSQL
}