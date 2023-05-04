variable "kind_cluster_name" {
  type        = string
  description = "The name of the cluster."
  default     = "terraform"
}

variable "kind_cluster_config_path" {
  type        = string
  description = "The location where this cluster's kubeconfig will be saved to."
  default     = "~/.kube/config"
}

variable "ingress_nginx_helm_version" {
  type        = string
  description = "The Helm version for the nginx ingress controller."
  default     = "4.5.2"
}

variable "ingress_nginx_namespace" {
  type        = string
  description = "The nginx ingress namespace (it will be created if needed)."
  default     = "ingress-nginx"
}

variable "ipaddress" {
  type        = string
  description = "IP Address of the local host."
}

variable "metallb_location" {
  type        = string
  description = "The location of the metallb configuration"
  default     = "Volumes/LaCie/POC/MetalLB"
}