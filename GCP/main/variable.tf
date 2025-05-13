variable "Project" {
        default = "k8s-kodi-cluster"
}

variable "Env" {
        default = "dev"
}

variable "Company" { 
        default = "kodi"
}

variable "Public_subnet" {
        default = "0.0.0.0/0"
}

variable "Private_subnet" {
        type = list(string)
        default = ["172.16.1.0/24","172.16.2.0/24","172.16.3.0/24","172.16.4.0/24"]
}

variable "Private_subnet_k8s" {
        type = list(string)
        default = ["10.0.0.0/20"]
}

variable "zone_map_europe-west3" {
        type = map(string)
        default = {
        #     vm1 =  "europe-west3-a"
        #     vm2 =  "europe-west3-a"
        #     vm3 =  "europe-west3-a"
            vm4 =  "europe-west3-a"
        }
}

variable "type_map_europe-west3" {
        type = list(string)
        default = ["e2-micro","e2-small","e2-medium"]
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

variable "zone_name_map_europe" {
        type = map(string)
        default = {
            ghost1 =  "europe-west4-a"
        #     ghost2 =  "europe-west4-a"
        #     ghost3 =  "europe-west4-a"
        #     ghost4 =  "europe-west4-a"
        }
}

variable "machine_type_list_europe" {
        type = list(string)
        default = ["e2-micro","e2-small","e2-medium"]
}