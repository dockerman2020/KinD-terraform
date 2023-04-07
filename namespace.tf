resource "kubernetes_manifest" "namespace_dev" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Namespace"
    "metadata" = {
      "labels" = {
        "kubernetes.io/metadata.name" = "dev"
      }
      "name" = "dev"
    }
    "spec" = {}
  }
  depends_on = [
    kind_cluster.default
  ]
}

resource "kubernetes_manifest" "deployment_dev_hello_app" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "annotations" = {
        "deployment.kubernetes.io/revision" = "1"
      }
      "name" = "hello-app"
      "namespace" = "dev"
    }
    "spec" = {
      "progressDeadlineSeconds" = 600
      "replicas" = 3
      "revisionHistoryLimit" = 10
      "selector" = {
        "matchLabels" = {
          "app" = "hello"
        }
      }
      "strategy" = {
        "rollingUpdate" = {
          "maxSurge" = "25%"
          "maxUnavailable" = "25%"
        }
        "type" = "RollingUpdate"
      }
      "template" = {
        "metadata" = {
          "creationTimestamp" = null
          "labels" = {
            "app" = "hello"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "gcr.io/google-samples/hello-app:2.0"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "hello"
              "resources" = {}
              "terminationMessagePath" = "/dev/termination-log"
              "terminationMessagePolicy" = "File"
            },
          ]
          "dnsPolicy" = "ClusterFirst"
          "restartPolicy" = "Always"
          "schedulerName" = "default-scheduler"
          "securityContext" = {}
          "terminationGracePeriodSeconds" = 30
        }
      }
    }
  }
  depends_on = [
    kubernetes_manifest.namespace_dev
  ]
}

resource "kubernetes_manifest" "service_dev_hello_service" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Service"
    "metadata" = {
      "labels" = {
        "app" = "hello"
      }
      "name" = "hello-service"
      "namespace" = "dev"
    }
    "spec" = {
      "clusterIP" = "10.96.121.149"
      "clusterIPs" = [
        "10.96.121.149",
      ]
      "internalTrafficPolicy" = "Cluster"
      "ipFamilies" = [
        "IPv4",
      ]
      "ipFamilyPolicy" = "SingleStack"
      "ports" = [
        {
          "port" = 80
          "protocol" = "TCP"
          "targetPort" = 8080
        },
      ]
      "selector" = {
        "app" = "hello"
      }
      "sessionAffinity" = "None"
      "type" = "ClusterIP"
    }
  }
  depends_on = [
    kubernetes_manifest.deployment_dev_hello_app
  ]
}

resource "kubernetes_manifest" "ingress_dev_test_ingress" {
  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind" = "Ingress"
    "metadata" = {
      "name" = "test-ingress"
      "namespace" = "dev"
    }
    "spec" = {
      "ingressClassName" = "nginx"
      "rules" = [
        {
          "host" = "demo.absip.hack"
          "http" = {
            "paths" = [
              {
                "backend" = {
                  "service" = {
                    "name" = "hello-service"
                    "port" = {
                      "number" = 80
                    }
                  }
                }
                "path" = "/"
                "pathType" = "Prefix"
              },
            ]
          }
        },
      ]
    }
  }
  depends_on = [
    kubernetes_manifest.namespace_dev
  ]
}
