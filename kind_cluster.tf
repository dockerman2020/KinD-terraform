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
          disableDefaultCNI: true
          podSubnet: ${var.kind-pubsubnet}
          apiServerAddress: ${var.ipaddress}
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
          image: kindest/node:${var.kind-image}
        - role: worker
          extraMounts:
          - hostPath: ${var.kind-hostpath}
            containerPath: ${var.kind-containerpath}
          - hostPath: /var/run/docker.sock
            containerPath: /var/run/docker.sock
          image: kindest/node:${var.kind-image}
        - role: worker
          extraMounts:
          - hostPath: ${var.kind-hostpath}
            containerPath: ${var.kind-containerpath}
          - hostPath: /var/run/docker.sock
            containerPath: /var/run/docker.sock
          image: kindest/node:${var.kind-image}
        - role: worker
          extraMounts:
          - hostPath: ${var.kind-hostpath}
            containerPath: ${var.kind-containerpath}
          - hostPath: /var/run/docker.sock
            containerPath: /var/run/docker.sock
          image: kindest/node:${var.kind-image}
    EOF
}