variable "GOOGLE_PROJECT" {
  type        = string
  description = "Google project"
}

variable "GOOGLE_REGION" {
  type        = string
#  default     = "us-central1-a"
  description = "GCP region name"
}

variable "GKE_NAME" {
  type        = string
  description = "GKE cluster name"
}

variable "GKE_NUM_NODES" {
  type        = number
  description = "Initial number of GKE cluster nodes"

}

variable "GKE_MACHINE_TYPE" {
  type        = string
#  default     = "e2-micro"
  description = "GKE VM types"
}