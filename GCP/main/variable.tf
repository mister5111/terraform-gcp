variable "project" {
  default = "k8s-kodi-cluster"
}

locals {
  # VM create in dev and prod
  create_instances_count = contains(["dev", "prod"], terraform.workspace)
}

locals {
  # VM create in dev and prod
  create_k8s_count = contains(["dev"], terraform.workspace)
}

locals {
  # VM create in dev and prod
  create_instances_for_each = terraform.workspace == "dev" ? {
    #     ghost1 = "europe-west4-a"
    #     ghost2 = "europe-west4-a"
    #     ghost3 = "europe-west4-a"
    #     ghost4 = "europe-west4-a"
    } : terraform.workspace == "prod" ? {
    #     ghost1 = "europe-west4-a"
    #     ghost2 = "europe-west4-a"
    #     ghost3 = "europe-west4-a"
    #     ghost4 = "europe-west4-a"
  } : {}
}

variable "public_subnet" {
  default = "0.0.0.0/0"
}

variable "private_subnet" {
  type = list(string)
  default = [
    "172.16.1.0/24",
    "172.16.2.0/24",
    "172.16.3.0/24",
    "172.16.4.0/24"
  ]
}

variable "private_subnet_k8s" {
  type    = list(string)
  default = ["10.0.0.0/20"]
}

variable "zone_list_europe" {
  type = list(string)
  default = [
    "europe-west1",
    "europe-west2",
    "europe-west3",
    "europe-west4",
    "europe-west5",
    "europe-west6",
    "europe-west8",
    "europe-west9",
    "europe-west10",
    "europe-west12",
    "europe-central2",
    "europe-north1",
    "europe-southwest1",
  ]
}

variable "machine_type_list_europe" {
  type = list(string)
  default = [
    "e2-micro",
    "e2-small",
    "e2-medium"
  ]
}


locals {
  machine_type_map = {
    dev  = var.machine_type_list_europe[0]
    prod = var.machine_type_list_europe[2]
  }

  selected_machine_type = lookup(local.machine_type_map, terraform.workspace, var.machine_type_list_europe[1])
}