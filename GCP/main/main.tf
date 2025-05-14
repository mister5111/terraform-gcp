provider "google" {
  project = var.Project
}

terraform {
  backend "gcs" {
    bucket  = "kodi-terraform-state-bucket"
    prefix  = "terraform/state"
  }
}

module "global" {
  source            = "../modules/global" 
  env               = var.Env
  company           = var.Company
  external_cidr     = var.Public_subnet
  internal_cidr     = var.Private_subnet
}

module "europe" {
  source                = "../modules/europe"
  internal_cidr         = var.Private_subnet
  network_global        = module.global.global_firewall_name
  env                   = var.Env
  zone_names            = var.zone_list_europe
  name_and_zone         = var.name_zone_map_europe
  type_machine          = var.machine_type_list_europe
}

module "k8s_api_service" {
  source                = "../modules/k8s/api-service"
  company               = var.Company 
  internal_cidr         = var.Private_subnet_k8s
  network_global        = module.global.global_firewall_name
  env                   = var.Env
  zone_names            = var.zone_list_europe
  type_machine          = var.machine_type_list_europe
  project               = var.Project
}

module "PostgreSQL" {
  source                = "../modules/cloud-sql/postgreSQL"
  env                   = var.Env
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

output "PostgreSQL" {
  value = module.PostgreSQL
}