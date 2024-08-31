provider "google" {
  project = var.GOOGLE_PROJECT
  region  = var.GOOGLE_REGION
}

provider "flux" {
  kubernetes = {
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
