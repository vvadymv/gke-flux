terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.42.0"
    }
  }
  backend "gcs" {
    bucket = "m7-devops-tfstate"
    prefix = "tf-init"
  }
}

provider "google" {
  project = var.GOOGLE_PROJECT
  region  = var.GOOGLE_REGION
}

module "gke_cluster" {
  source         = "github.com/vvadymv/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GKE_NAME = var.GKE_NAME
  GKE_NUM_NODES  = var.GKE_NUM_NODES
  GKE_MACHINE_TYPE = var.GKE_MACHINE_TYPE
}
