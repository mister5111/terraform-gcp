# resource "kubernetes_namespace" "api_service" {
#   count    =  var.counts ? 1 : 0
#   metadata {
#     name = "api-service"
#   }
# }

# resource "helm_release" "nginx_ingress" {
#   count    =  var.counts ? 1 : 0
#   name       = "ingress-nginx"
#   namespace  = "ingress-nginx"
#   create_namespace = true

#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart      = "ingress-nginx"
#   version    = "4.10.0"

#   values     = [
#             <<EOF
#             controller:
#                 replicaCount: 2
#                 publishService:
#                     enabled: true
#             EOF
#             ]
# }

#  resource "kubernetes_deployment" "api_service" {
#   count    =  var.counts ? 1 : 0
#   metadata {
#     name      = "api-service"
#     namespace = kubernetes_namespace.api_service[0].metadata[0].name
#   }

#   spec {
#     replicas = 2

#     selector {
#       match_labels = {
#         app        = "api-service"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app  = "api-service"
#         }
#       }

#       spec {
#         container {
#           name             = "api-service"
#           image            = "yevhenshevchenko1988/api-service:8080"
#           port {
#             container_port = 8080
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "api_service" {
#   count    =  var.counts ? 1 : 0
#   metadata {
#     name      = "api-service"
#     namespace = kubernetes_namespace.api_service[0].metadata[0].name
#   }

#   spec {
#     selector = {
#       app    = "api-service"
#     }

#     port {
#       port        = 8080
#       target_port = 8080
#     }

#     type          = "ClusterIP"
#   }
# }

# resource "kubernetes_ingress_v1" "api_ingress" {
#   count    =  var.counts ? 1 : 0
#   metadata {
#     name        = "api-ingress"
#     namespace   = kubernetes_namespace.api_service[0].metadata[0].name

#     annotations = {
#       "nginx.ingress.kubernetes.io/rewrite-target" = "/"
#     }
#   }

#   spec {
#     ingress_class_name = "nginx"

#     rule {

#       http {
#         path {
#           path      = "/"
#           path_type = "Prefix"

#           backend {
#             service {
#               name = kubernetes_service.api_service[0].metadata[0].name
#               port {
#                 number = 8080
#               }
#             }
#           }
#         }
#       }
#     }
#   }
# }