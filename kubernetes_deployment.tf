resource "kubernetes_deployment" "alb_ingress_controller" {
  metadata {
    name = var.kubernetes_deployment_name
    namespace = var.kubernetes_namespace
    labels = {
      "app.kubernetes.io/name" = "tf-aws-kube-alb-ingress-controller"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        "app.kubernetes.io/name" = "tf-aws-kube-alb-ingress-controller"
      }
    }

    template {
      metadata {
        labels = {
          "app.kubernetes.io/name" = "tf-aws-kube-alb-ingress-controller"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.alb_ingress_controller.metadata.0.name

        container {
          image = "docker.io/amazon/aws-alb-ingress-controller:v1.1.2"
          name = "alb-ingress-controller"

          args = local.kube_container_args

          volume_mount { # hack for automountServiceAccountToken
            name = kubernetes_service_account.alb_ingress_controller.default_secret_name
            mount_path = "/var/run/secrets/kubernetes.io/serviceaccount"
            read_only = true
          }

          image_pull_policy = "Always"
        }

        volume { # hack for automountServiceAccountToken
          name = kubernetes_service_account.alb_ingress_controller.default_secret_name
          secret {
            secret_name = kubernetes_service_account.alb_ingress_controller.default_secret_name
          }
        }
      }
    }
  }
}
