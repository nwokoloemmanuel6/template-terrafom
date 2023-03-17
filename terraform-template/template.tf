resource "kubernetes_deployment" "kube-deployment" {
  metadata {
    name      = ""
    namespace =  kubernetes_namespace.kube-namespace.id
    labels = {
      name = ""
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = ""
        app = ""
      }
    }
    template {
      metadata {
        name =  ""
        labels = {
          name = ""
          app = ""
        }
      }
      spec {
        container {
          image = ""
          name  = ""

      port {
        container_port = 80
      }
      }
    }
  }
}
}


# Create kubernetes  for cart service

resource "kubernetes_service" "kube-service" {
  metadata {
    name      = ""
    namespace =  kubernetes_namespace.kube-namespace.id
    annotations = {
        prometheus.io/scrape: "true"
    }

    labels = {
        name = ""
        app = ""
    }
  }
  spec {
    selector = {
      name = ""
      app = ""
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}
