resource "kubernetes_namespace" "test" {
  metadata {
    name = "${local.stage}-namespace"
  }
}

resource "kubernetes_deployment" "test" {
  metadata {
    name      = "${local.stage}-nginx"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "${local.stage}-MyTestApp"
      }
    }
    template {
      metadata {
        labels = {
          app = "${local.stage}-MyTestApp"
        }
      }
      spec {
        container {
          image = "nginx"
          name  = "${local.stage}-nginx-container"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "test" {
  metadata {
    name      = "${local.stage}-nginx"
    namespace = kubernetes_namespace.test.metadata.0.name
  }
  spec {
    selector = {
      app = kubernetes_deployment.test.spec.0.template.0.metadata.0.labels.app
    }
    type = "NodePort"
    port {
      node_port   = 30201
      port        = 80
      target_port = 80
    }
  }
}