# output "cluster_api_service_name" {
#   value = [for i in google_container_cluster.api_service : {
#     name =  i.name
#     }
#   ]
# }

# output "api_ingress_ip" {
#   value = [for i in kubernetes_ingress_v1.api_ingress : {
#     ip = i.status[0].load_balancer[0].ingress[0].ip
#     }
#   ]
# }