provider "kind" {
}

provider "kubernetes" {
  config_path = pathexpand(var.kind_cluster_config_path)
}

resource "kind_cluster" "default" {
    name            = var.kind_cluster_name
    node_image      = "kindest/node:v1.26.2"
    kubeconfig_path = pathexpand(var.kind_cluster_config_path)
    wait_for_ready  = true

  kind_config {
      kind        = "Cluster"
      api_version = "kind.x-k8s.io/v1alpha4"
      networking {
        api_server_address = (var.ipaddress)
        api_server_port   = 58366
      }
      containerd_config_patches = [
        <<-TOML
        [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:5000"]
            endpoint = ["http://kind-registry:5000"]
        TOML
         ]
      node {
          role = "control-plane"

          kubeadm_config_patches = [
            "kind: InitConfiguration\nnodeRegistration:\n  kubeletExtraArgs:\n    node-labels: \"ingress-ready=true\"\n"
          ]

          extra_port_mappings {
              container_port = 80
              host_port      = 80
          }
          extra_port_mappings {
              container_port = 443
              host_port      = 443
          }
      }
      node {
          role = "worker"
      }
      node {
          role = "worker"
      }
      node {
          role = "worker"
      }
  }
}
