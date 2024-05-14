
resource "google_compute_instance" "tf-instance-1" {
  name         = "tf-instance-1"
  machine_type = var.machine_type
  zone         = var.zone


  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20240415"
      
    }
  }

 
  network_interface {
    network = var.network_name
    # subnetwork = "subnet-01"
  }


  metadata_startup_script = <<-EOT
        #!/bin/bash 
    EOT


  allow_stopping_for_update = true



}
resource "google_compute_instance" "tf-instance-2" {
  name         = "tf-instance-2"
  machine_type = var.machine_type
  zone         = var.zone



  boot_disk {
    initialize_params {
      image = "debian-11-bullseye-v20240415"
      
    }
  }

  network_interface {
    network = var.network_name
    # subnetwork = "subnet-02"
  }

   

  metadata_startup_script = <<-EOT
        #!/bin/bash 
    EOT

  allow_stopping_for_update = true

}

# resource "google_compute_instance" "tf-instance-3" {
#   name         = "tf-instance-994061"
#   machine_type = "e2-standard-2"
#   zone         = "us-east1-b"



#   boot_disk {
#     initialize_params {
#       image = "debian-11-bullseye-v20240415"
      
#     }
#   }
  
#   network_interface {
#     network = "default"
#   }

#   metadata_startup_script = <<-EOT
#         #!/bin/bash
#     EOT

#   allow_stopping_for_update = true

# }