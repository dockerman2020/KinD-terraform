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
  description = "IP Address of the local host (To be used for the KinD cluster address)."
}

variable "ip_port" {
  type        = string
  description = "Port number, so kinD will not generate and assign random port."
  default     = "58350"
}

variable "metallb_location" {
  type        = string
  description = "The location of the metallb configuration"
  default     = "/Volumes/LaCie/POC/MetalLB"
}

variable "kind-hostpath" {
  type = string
  description = "The kind host path on the local machine"
  default = "/Users/emmanuelmamudu/ContainerData"
}

variable "kind-containerpath" {
  type = string
  description = "The kind container path."
  default = "/ContainerData"
}

variable "kind-image" {
  type = string
  description = "kind image"
  default = "v1.27.1@sha256:c83b0c44292af82e7d2972c121436bf91a6a47dd0fff0d4678240ec46f635d31"
}

variable "kind-pubsubnet" {
  type = string
  description = "The kind calico subnet."
  default = "192.168.0.0/16"
}