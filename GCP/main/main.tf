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

module "europe-west3" {
  source                = "../modules/europe-west3"
  company               = var.Company 
  internal_cidr         = var.Private_subnet
  network_global        = module.global.global_firewall_name
  env                   = var.Env
  zone_names            = var.zone_map_europe-west3
  type_names            = var.type_map_europe-west3
}

module "europe" {
  source                = "../modules/europe"
  internal_cidr         = var.Private_subnet
  network_global        = module.global.global_firewall_name
  env                   = var.Env
  zone_names            = var.zone_list_europe
  zone_and_name         = var.zone_name_map_europe
  type_machine          = var.machine_type_list_europe
}

### k8s_api_service ###
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
### k8s_api_service ###

### PostgreSQL ###
module "PostgreSQL" {
  source                = "../modules/cloud-sql/postgreSQL"
  env                   = var.Env
  zone_names            = var.zone_list_europe
}
### PostgreSQL ###




output "global" {
  value = module.global
}

output "europe-west3_module_outputs" {
  value = module.europe-west3
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