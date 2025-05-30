resource "google_compute_instance" "docker" {
  count         =  var.counts ? 0 : 0
  name          = format("%s-%02d-docker", var.env, count.index + 1)
  machine_type  = var.type_machine
  zone          = format("%s-a",var.zone_names[1])
  tags          = ["ssh","http","https","icmp"]
  boot_disk  {
    initialize_params {
      image     = "debian-cloud/debian-12"     
    }
  }
  labels = {
    webserver =  "true"     
    }
  metadata = {
    startup-script = <<SCRIPT
    apt-get -y update
    apt-get -y upgrade    
    SCRIPT
    } 

  network_interface {
    subnetwork = google_compute_subnetwork.default-1.id
    access_config {}
  }
}

resource "google_compute_instance" "ghost" {
  for_each      = var.name_and_zone
  name          = format("%s-%s-%s", var.env, each.key, var.type_machine)
  machine_type  = var.type_machine
  zone          = each.value
  tags          = ["ssh","http","https","icmp"]
  boot_disk  {
    initialize_params {
      image     = "debian-cloud/debian-12"     
    }
  }
  labels = {
    webserver =  "true"     
    }
  metadata = {
    startup-script = <<SCRIPT
    apt-get -y update
    apt-get -y upgrade
    SCRIPT
    } 

  network_interface {
    subnetwork = google_compute_subnetwork.default-2.id
    access_config {}
  }
}
