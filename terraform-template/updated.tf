# Create kubernetes deployment for cart 

resource "kubernetes_deployment" "kube-catalogue-deployment" {
  metadata {
    name      = "catalogue"
    namespace = kubernetes_namespace.kube-namespace.id
    labels = {
      name = "catalogue"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "catalogue"
      }
    }
    template {
      metadata {
        labels = {
          name = "catalogue"
        }
      }
      spec {
        container {
          image = "weaveworksdemos/catalogue:0.3.5"
          name  = "catalogue"
          command = ["/app"]
          args = [ "-port=80" ]
          resources {
            limits = {
              cpu = "200m"
              memory = "200Mi"
            }
            requests = {
              cpu = "100m"
              memory = "100Mi"
            }
          }

          port {
            container_port = 80
          }

            security_context {
                capabilities {
                drop = ["ALL"]
                add = ["NET_BIND_SERVICE"]
                }

                read_only_root_filesystem = true
                run_as_non_root = true
                run_as_user = 10001
                #readOnlyRootFilesystem = true
                #runAsNonRoot = true
                #runAsUser = 10001
            }

            liveness_probe {
                http_get {
                    path = "/health"
                    port = 80
                }
                initial_delay_seconds = 300
                period_seconds = 3
            }

            readiness_probe {
                http_get {
                    path = "/health"
                    port = 80
                }
                initial_delay_seconds = 180
                period_seconds = 3
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

resource "kubernetes_service" "kube-catalogue-service" {
  metadata {
    name      = "catalogue"
    namespace = kubernetes_namespace.kube-namespace.id
   /*  annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "catalogue"
    }
  }
  spec {
    selector = {
      name = "catalogue"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}



# create kubernetes cart-db deployment


resource "kubernetes_deployment" "kube-catalogue-db-deployment" {
  metadata {
    name      = "catalogue-db"
    namespace = kubernetes_namespace.kube-namespace.id
    labels = {
      name = "catalogue-db"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        name = "catalogue-db"
      }
    }
    template {
      metadata {
        labels = {
          name = "catalogue-db"
        }
      }
      spec {
        container {
          image = "weaveworksdemos/catalogue-db:0.3.0"
          name  = "catalogue-db"

        port {
        name = "mysql"
        container_port = 3306
      }
      env {
        name = "MYSQL_ROOT_PASSWORD"
        value = "fake_password"
      }

      env {
        name = "MYSQL_DATABASE"
        value = "socksdb"
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

resource "kubernetes_service" "kube-catalogue-db-service" {
  metadata {
    name      = "catalogue-db"
    namespace = kubernetes_namespace.kube-namespace.id
    labels = {
        name = "catalogue-db"
    }
  }
  spec {
    selector = {
      name = "catalogue-db"
    }
    port {
      port        = 3306
      target_port = 3306
    }
  }
}
