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
    flux = {
      source  = "fluxcd/flux"
      version = ">= 1.2"
    }
    github = {
      source  = "integrations/github"
      version = ">= 6.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0"
    }
  }
  backend "gcs" {
    bucket = "m7-devops-tfstate"
    prefix = "tf-flux-gke"
  }
}

# GKE cluster
module "gke_cluster" {
  source         = "github.com/vvadymv/tf-google-gke-cluster"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GKE_NAME = var.GKE_NAME
  GKE_NUM_NODES  = var.GKE_NUM_NODES
  GKE_MACHINE_TYPE = var.GKE_MACHINE_TYPE
}

# Github repo
## Repository definition
resource "github_repository" "this" {
  name        = var.GITHUB_REPOSITORY
  description = var.GITHUB_REPOSITORY
  auto_init   = true # This is extremely important as flux_bootstrap_git will not work without a repository that has been initialised
}

## Generate key for ssh
resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

## Set ssh key to repo
resource "github_repository_deploy_key" "this" {
  title      = "Flux"
  repository = github_repository.this.name
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

# Setup cluster with flux
resource "flux_bootstrap_git" "this" {
  depends_on = [github_repository_deploy_key.this]

  embedded_manifests = true
  path               = "clusters/my-cluster"
}