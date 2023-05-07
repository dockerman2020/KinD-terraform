provider "kind" {
}

provider "kubernetes" {
  config_path = pathexpand(var.kind_cluster_config_path)
}

resource "kind_cluster" "default" {
  name   = var.kind_cluster_name
  config = <<-EOF
        apiVersion: kind.x-k8s.io/v1alpha4
        kind: Cluster
        networking:
          apiServerAddress: "${var.ipaddress}"
          apiServerPort: ${var.ip_port}
        nodes:
        - role: control-plane
          kubeadmConfigPatches:
          - |
            # kind: ClusterConfiguration
            # apiServer:
            #     extraArgs:
            #       enable-admission-plugins: NodeRestriction,MutatingAdmissionWebhook,ValidatingAdmissionWebhook
            kind:  InitConfiguration
            nodeRegistration:
                kubeletExtraArgs:
                  node-labels: ingress-ready=true
          extraPortMappings:
          - containerPort: 80
            hostPort: 80
            listenAddress: "127.0.0.1"
            protocol: TCP
          - containerPort: 443
            hostPort: 443
            listenAddress: "127.0.0.1"
            protocol: TCP
          image: kindest/node:v1.27.1@sha256:c83b0c44292af82e7d2972c121436bf91a6a47dd0fff0d4678240ec46f635d31
        - role: worker
          extraMounts:
          # - hostPath: /Volumes/LaCie/POC/Vols/data
          #   containerPath: /data
          - hostPath: /Users/emmanuelmamudu/ContainerData
            containerPath: /ContainerData
          image: kindest/node:v1.27.1@sha256:c83b0c44292af82e7d2972c121436bf91a6a47dd0fff0d4678240ec46f635d31
        - role: worker
          extraMounts:
          - hostPath: /Users/emmanuelmamudu/ContainerData
            containerPath: /ContainerData
          # - hostPath: /Volumes/LaCie/POC/Vols/data
          #   containerPath: /data
          image: kindest/node:v1.27.1@sha256:c83b0c44292af82e7d2972c121436bf91a6a47dd0fff0d4678240ec46f635d31
        - role: worker
          extraMounts:
          - hostPath: /Users/emmanuelmamudu/ContainerData
            containerPath: /ContainerData
          # - hostPath: /Volumes/LaCie/POC/Vols/data
          #   containerPath: /data
          image: kindest/node:v1.27.1@sha256:c83b0c44292af82e7d2972c121436bf91a6a47dd0fff0d4678240ec46f635d31
    EOF
}