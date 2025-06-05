output "instance_names-europe_docker" {
  value = [for i in google_compute_instance.docker : {
    name =  i.name
    ip = i.network_interface[0].access_config[0].nat_ip
    }
  ]
}

output "instance_names-europe_vm" {
  value = [for i in google_compute_instance.vm : {
    name =  i.name
    ip = i.network_interface[0].access_config[0].nat_ip
    }
  ]
}