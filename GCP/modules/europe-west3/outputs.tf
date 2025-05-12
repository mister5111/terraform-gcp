output "instance_names-europe-west3" {
  value = [for i in google_compute_instance.default : {
    name =  i.name
    ip = i.network_interface[0].access_config[0].nat_ip
    }
  ]
}