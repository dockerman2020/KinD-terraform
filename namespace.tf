# # resource "kubernetes_namespace" "namespace_develop" {
# #   manifest = {
# #     "apiVersion" = "v1"
# #     "kind" = "Namespace"
# #     "metadata" = {
# #       "labels" = {
# #         "kubernetes.io/metadata.name" = "develop"
# #       }
# #       "name" = "develop"
# #     }
# #     "spec" = {}
# #   }
# #   depends_on = [
# #     kind_cluster.default
# #   ]
# # }

# resource "kubernetes_namespace" "namespace_develop" {
#   metadata {
#     annotations = {
#       name = "develop-annotation"
#     }
#     labels = {
#       mylabel = "develop"
#     }
#     name = "develop"
#   }
#   depends_on = [
#     kind_cluster.default
#   ]  
# }

# resource "kubernetes_namespace" "deployment_dev_hello_app" {
#   manifest = {
#     "apiVersion" = "apps/v1"
#     "kind" = "Deployment"
#     "metadata" = {
#       "annotations" = {
#         "deployment.kubernetes.io/revision" = "1"
#       }
#       "name" = "hello-app"
#       "namespace" = "develop"
#     }
#     "spec" = {
#       "progressDeadlineSeconds" = 600
#       "replicas" = 3
#       "revisionHistoryLimit" = 10
#       "selector" = {
#         "matchLabels" = {
#           "app" = "hello"
#         }
#       }
#       "strategy" = {
#         "rollingUpdate" = {
#           "maxSurge" = "25%"
#           "maxUnavailable" = "25%"
#         }
#         "type" = "RollingUpdate"
#       }
#       "template" = {
#         "metadata" = {
#           "creationTimestamp" = null
#           "labels" = {
#             "app" = "hello"
#           }
#         }
#         "spec" = {
#           "containers" = [
#             {
#               "image" = "gcr.io/google-samples/hello-app:2.0"
#               "imagePullPolicy" = "IfNotPresent"
#               "name" = "hello"
#               "resources" = {}
#               "terminationMessagePath" = "/dev/termination-log"
#               "terminationMessagePolicy" = "File"
#             },
#           ]
#           "dnsPolicy" = "ClusterFirst"
#           "restartPolicy" = "Always"
#           "schedulerName" = "default-scheduler"
#           "securityContext" = {}
#           "terminationGracePeriodSeconds" = 30
#         }
#       }
#     }
#   }
#   depends_on = [
#     kubernetes_namespace.namespace_develop
#   ]
# }

# resource "kubernetes_namespace" "service_dev_hello_service" {
#   manifest = {
#     "apiVersion" = "v1"
#     "kind" = "Service"
#     "metadata" = {
#       "labels" = {
#         "app" = "hello"
#       }
#       "name" = "hello-service"
#       "namespace" = "develop"
#     }
#     "spec" = {
#       "clusterIP" = "10.96.121.149"
#       "clusterIPs" = [
#         "10.96.121.149",
#       ]
#       "internalTrafficPolicy" = "Cluster"
#       "ipFamilies" = [
#         "IPv4",
#       ]
#       "ipFamilyPolicy" = "SingleStack"
#       "ports" = [
#         {
#           "port" = 80
#           "protocol" = "TCP"
#           "targetPort" = 8080
#         },
#       ]
#       "selector" = {
#         "app" = "hello"
#       }
#       "sessionAffinity" = "None"
#       "type" = "ClusterIP"
#     }
#   }
#   depends_on = [
#     kubernetes_namespace.deployment_dev_hello_app
#   ]
# }

# resource "kubernetes_namespace" "ingress_dev_test_ingress" {
#   manifest = {
#     "apiVersion" = "networking.k8s.io/v1"
#     "kind" = "Ingress"
#     "metadata" = {
#       "name" = "test-ingress"
#       "namespace" = "develop"
#     }
#     "spec" = {
#       "ingressClassName" = "nginx"
#       "rules" = [
#         {
#           "host" = "demo.absip.hack"
#           "http" = {
#             "paths" = [
#               {
#                 "backend" = {
#                   "service" = {
#                     "name" = "hello-service"
#                     "port" = {
#                       "number" = 80
#                     }
#                   }
#                 }
#                 "path" = "/"
#                 "pathType" = "Prefix"
#               },
#             ]
#           }
#         },
#       ]
#     }
#   }
#   depends_on = [
#     kubernetes_namespace.namespace_develop
#   ]
# }

resource "kubernetes_namespace" "dev_ns" {
  metadata {
    annotations = {
      name = "dev-annotation"
    }

    labels = {
      "kubernetes.io/metadata.name" = "dev"
    }

    name = "dev"
  }
  depends_on = [
    kind_cluster.default
  ]
}