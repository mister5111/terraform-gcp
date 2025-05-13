output "instance_names-europe_docker-builder" {
  value = [for i in google_compute_instance.docker-builder : {
    name =  i.name
    ip = i.network_interface[0].access_config[0].nat_ip
    }
  ]
}

output "instance_names-europe_ghost" {
  value = [for i in google_compute_instance.ghost : {
    name =  i.name
    ip = i.network_interface[0].access_config[0].nat_ip
    }
  ]
}