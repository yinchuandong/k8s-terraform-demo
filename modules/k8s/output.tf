output "service_id" {
  value = kubernetes_service.test.id
}

output "namespace" {
  value = kubernetes_namespace.test.metadata.0.name
}