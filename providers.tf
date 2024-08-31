provider "google" {
  project = var.GOOGLE_PROJECT
  region  = var.GOOGLE_REGION
}

#provider "kubernetes" {
#  host                   = "https://${module.gke_cluster.endpoint}"
#  token                  = data.google_client_config.default.access_token
#  cluster_ca_certificate = base64decode(module.gke_cluster.ca_certificate)
#}

provider "flux" {
  kubernetes = {
    config_path = "~/.kube/config_gke-flux"
  }
  git = {
    url = "ssh://git@github.com/${var.GITHUB_ORG}/${var.GITHUB_REPOSITORY}.git"
    ssh = {
      username    = "git"
      private_key = tls_private_key.flux.private_key_pem
    }
  }
}

provider "github" {
  owner = var.GITHUB_ORG
  token = var.GITHUB_TOKEN
}
