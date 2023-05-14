# resource "kubernetes_namespace" "dev_ns" {
#   metadata {
#     annotations = {
#       name = "dev-annotation"
#     }

#     labels = {
#       "kubernetes.io/metadata.name" = "dev"
#     }

#     name = "dev"
#   }
#   depends_on = [
#     kind_cluster.default
#   ]
# }

resource "kubernetes_namespace" "sonarqube_ns" {
  metadata {
    annotations = {
      name = "sonarqube"
    }
    labels = {
      "kubernetes.io/metadata.name" = "sonarqube"
    }
    name = "sonarqube"
  }
  depends_on = [helm_release.ingress_nginx]
}

resource "kubernetes_namespace" "trivy-redis_ns" {
  metadata {
    annotations = {
      name = "trivy-redis"
    }
    labels = {
      "kubernetes.io/metadata.name" = "trivy-redis"
    }
    name = "trivy-redis"
  }
  depends_on = [helm_release.ingress_nginx]

}

resource "kubernetes_namespace" "jenkins_ns" {
  metadata {
    annotations = {
      name = "jenkins-annotation"
    }
    labels = {
      "kubernetes.io/metadata.name" = "jenkins"
    }
    name = "jenkins"
  }
}

resource "kubernetes_namespace" "jenkins_worker_ns" {
  metadata {
    annotations = {
      name = "jenkins-worker"
    }
    labels = {
      "kubernetes.io/metadata.name" = "jenkins-worker"
    }
    name = "jenkins-worker"
  }
  depends_on = [helm_release.ingress_nginx]
}

resource "kubernetes_namespace" "argocd_ns" {
  metadata {
    annotations = {
      name = "argocd"
    }
    labels = {
      "kubernetes.io/metadata.name" = "argocd"
    }
    name = "argocd"
  }
  depends_on = [helm_release.ingress_nginx]
}
