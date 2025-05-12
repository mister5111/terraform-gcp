output "cluster_api_service_name" {
    value =  google_container_cluster.api_service.name 
}

output "api_ingress_ip" {
    value = kubernetes_ingress_v1.api_ingress.status[0].load_balancer[0].ingress[0].ip
}

