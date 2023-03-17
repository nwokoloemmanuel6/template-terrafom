# Create kubernetes deployment for cart 

resource "kubernetes_deployment" "nameOfDeployment" {
  metadata {
    name      = ""
    namespace = kubernetes_namespace.kube-namespace.id
    labels = {
      name = ""
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = ""
      }
    }
    template {
      metadata {
        labels = {
          name = ""
        }
      }
      spec {
        container {
          image = ""
          name  = ""

      env {
        name = "JAVA_OPTS"
        value = "-Xms64m -Xmx128m -XX:+UseG1GC -Djava.security.egd=file:/dev/urandom -Dspring.zipkin.enabled=false"
      }

      resources {
        limits {
          cpu = ""
          memory = ""
        }
        requests {
          cpu = ""
          memory = ""
        }
      }

      port {
        container_port = 80
      }

      securityContext {
        capabilities {
          drop = ["ALL"]
          add = ["NET_BIND_SERVICE"]
        }
        privileged = false
        readOnlyRootFilesystem = true
        runAsNonRoot = true
        runAsUser = 10001
      }

      volumeMount {
        name = "tmp-volume"
        mountPath = "/tmp"
      }
        }
       
     volume {
        name = "tmp-volume"
        emptyDir {
            medium = "Memory"
        }
      }
         node_selector = {
        "beta.kubernetes.io/os" = "linux"
      }
      }
    }
  }
}




# Create kubernetes  for cart service

resource "kubernetes_service" "nameOfservice" {
  metadata {
    name      = ""
    namespace = kubernetes_namespace.kube-namespace.id
    annotations = {
        prometheus.io/scrape: "true"
    }

    labels = {
        name = ""
    }
  }
  spec {
    selector = {
      name = ""
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}



# create kubernetes cart-db deployment


resource "kubernetes_deployment" "nameOfDeployment" {
  metadata {
    name      = ""
    namespace = kubernetes_namespace.kube-namespace.id
    labels = {
      name = ""
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = ""
      }
    }
    template {
      metadata {
        labels = {
          name = ""
        }
      }
      spec {
        container {
          image = ""
          name  = ""

       port {
        name = ""
        container_port = 80
      }

      securityContext {
        capabilities {
          drop = ["ALL"]
          add = ["CHOWN", "SETGID", "SETUID"]
        }
        readOnlyRootFilesystem = false
            
        }

      volumeMount {
        name = "tmp-volume"
        mountPath = "/tmp"
      }

        }
     volume {
        name = "tmp-volume"
        emptyDir {
            medium = "Memory"
        }
      }
  
      node_selector = {
        "beta.kubernetes.io/os" = "linux"
      }

      }
    }
  }
}


# service for cart-db

resource "kubernetes_service" "nameOfservice" {
  metadata {
    name      = ""
    namespace = kubernetes_namespace.kube-namespace.id
    labels = {
        name = ""
    }
  }
  spec {
    selector = {
      name = ""
    }
    port {
      port        = 
      target_port = 
    }
  }
}
