terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.18.1"
    }
  }
}

provider "google" {
#   Set path to key file in GOOGLE_APPLICATION_CREDENTIALS variable or put it in credentials below
#   credentials =
  project     = "terraform-demo-449409"
  region      = "europe-central2"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "terraform-demo-449409-terra-bucket"
  location      = "EUROPE-CENTRAL2"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}