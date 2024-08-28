terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.42.0"
    }
    kind = {
      source = "tehcyx/kind"
      version = "0.6.0"
    }
  }
  backend "gcs" {
    bucket = "m7-devops-tfstate"
    prefix = "tf-flux"
  }
}

provider "kind" {}

#locals {
#    k8s_config_path = pathexpand("/tmp")
#}

resource "kind_cluster" "default" {
    name = var.GKE_NAME
#    kubeconfig_path = local.k8s_config_path
}