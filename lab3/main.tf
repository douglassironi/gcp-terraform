provider "google" {
  project     = "qwiklabs-gcp-03-0e7036c08ddd"
  region      = "us-central1"
}

resource "google_storage_bucket" "test-bucket-for-state" {
  name        = "qwiklabs-gcp-03-0e7036c08ddd"
  location    = "US"
  uniform_bucket_level_access = true
   force_destroy = true
}


# terraform {
#   backend "gcs" {
#     bucket  = "qwiklabs-gcp-03-0e7036c08ddd"
#     prefix  = "terraform/state"
#   }
# }

terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}

terraform {
  backend "local" {
    path = "terraform/state/terraform.tfstate"
  }
}

# 
# terraform init -migrate-state
#

# 
# terraform refresh
#

# 
# terraform show
#


# terraform import docker_container.web $(docker inspect -f {{.ID}} hashicorp-learn)