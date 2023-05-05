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