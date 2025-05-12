resource "google_compute_instance" "default" {
  for_each      = var.zone_names
  name          = format("%s-%s-instance-%s-%s", var.company, var.env, each.key, var.type_names[2])
  machine_type  = var.type_names[2]
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
    addgroup admin
    echo "# User rules for admin" >> /etc/sudoers.d/admin-group-sudoers
    echo "%admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/admin-group-sudoers
    useradd -g admin -s /bin/bash -m satrier && sudo -u satrier -s sh -c 'mkdir -p ~/.ssh && chmod 700 ~/.ssh && touch ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys && echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAl7kTY6vl33ACKbG2xO4WTTnriyHW28saAPe/1AZLuTYlH8diIlohplRydPRQXxM0JqY2h/SEPCe5JU1Rphh9tFZneg4BPf2eoLzOEnBaTazlWjhWlxfZoIA7x7JJvFXTxy7Z9kWwCLQEgPxs//Lxor3y0/7WK9EOtg8qNo5cCZ6KmClzbJfzeqoZS0GFC9asEBavWZ3YBbVi76o7TZ3kTlHyAalfRYCrzdVBEh0+C4iwcXQ9iESBGE2Hc+kSWf8axI4qK4lfdpqeOxcGsThX7YAKe0AwrSCjnA5atBuVtEIKoUS8bzWnXRGgM2XXmNxF6G8BOQZB/7vfJF+7W+qI0w== satrier" >> ~/.ssh/authorized_keys'
    SCRIPT
    } 

  network_interface {
    subnetwork = google_compute_subnetwork.default.id
    access_config {}
  }
}
