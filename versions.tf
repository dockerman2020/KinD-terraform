terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.0.16"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.18.1"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
  }

  required_version = ">= 1.0.0"
}

