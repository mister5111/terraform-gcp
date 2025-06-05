resource "google_compute_instance" "docker" {
  count         =  var.counts ? 0 : 0
  name          = format("%s-%02d-docker-%s", var.env, count.index + 1, var.s_info[0])
  machine_type  = var.type_machine
  zone          = format("%s-b",var.zone_names[0])
  tags          = ["ssh","http","https","icmp"]
  boot_disk  {
    initialize_params {
      image     = var.s_info[1]
    }
  }
  labels = {
    webserver =  var.s_info[2] 
    }
  metadata = {
    startup-script = <<SCRIPT
    #!/bin/bash
    export DEBIAN_FRONTEND=noninteractive
    apt update -y
    apt upgrade -yq
    apt install -y htop
    SCRIPT
}

  network_interface {
    subnetwork = google_compute_subnetwork.default-3.id
    access_config {}
  }
}

resource "google_compute_instance" "vm" {
  for_each      = var.name_and_zone
  name          = format("%s-%s-%s", var.env, each.key, var.type_machine)
  machine_type  = var.type_machine
  zone          = each.value
  tags          = ["ssh","http","https","icmp","custom-ssh"]
  allow_stopping_for_update = true
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
    #!/bin/bash
    export DEBIAN_FRONTEND=noninteractive
    apt update -y
    apt upgrade -yq
    SCRIPT
}

  network_interface {
    subnetwork = google_compute_subnetwork.default-3.id
    access_config {}
  }
}
