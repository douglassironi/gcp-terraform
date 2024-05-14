# 
#  How to import a existent resource.
# 
#  terraform import module.instances.google_compute_instance.tf-instance-2 qwiklabs-gcp-03-a8609322fa21/us-east1-b/tf-instance-2
# 

 


terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.27.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region = var.region
  zone = var.zone
}

module "storage_backend" {
  source = "./modules/storage"
}

module "instances" {
  source = "./modules/instances"
}

module "network" {
  source  = "terraform-google-modules/network/google"
  version = "9.1.0"
  project_id = var.project_id
  network_name = var.network_name
  routing_mode = "GLOBAL"    
   subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-east1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = "us-east1"
        }]
}


module "tf-firewall" {
  source       = "terraform-google-modules/network/google//modules/firewall-rules"
  project_id   = var.project_id
  network_name = module.network.network_name

  rules = [{
    name                    = "tf-firewall"
    description             = null
    direction               = "INGRESS"
    priority                = null
    destination_ranges      = ["0.0.0.0/0"]
    source_ranges           = ["0.0.0.0/0"]
    source_tags             = null
    source_service_accounts = null
    target_tags             = null
    target_service_accounts = null
    allow = [{
      protocol = "TCP"
      ports    = ["80"]
    }]
    deny = []
    log_config = {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }]
}



terraform {
  backend "gcs" {
    bucket  = var.bucket_name
    prefix  = "terraform/state"
  }
}
