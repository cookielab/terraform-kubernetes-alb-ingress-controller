resource "kubernetes_service_account" "alb_ingress_controller" {
  metadata {
    name = "${var.kubernetes_resources_name_prefix}alb-ingress-controller"
    namespace = var.kubernetes_namespace
    labels = local.kubernetes_resources_labels
  }
}

resource "kubernetes_cluster_role" "alb_ingress_controller" {
  metadata {
    name = "${var.kubernetes_resources_name_prefix}alb-ingress-controller"
    labels = local.kubernetes_resources_labels
  }

  rule {
    api_groups = ["", "extensions"]
    resources = ["configmaps", "endpoints", "events", "ingresses", "ingresses/status", "services"]
    verbs = ["create", "get", "list", "update", "watch", "patch"]
  }

  rule {
    api_groups = ["", "extensions"]
    resources = ["nodes", "pods", "secrets", "services", "namespaces"]
    verbs = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "alb_ingress_controller" {
  metadata {
    name = "${var.kubernetes_resources_name_prefix}alb-ingress-controller"
    labels = local.kubernetes_resources_labels
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = kubernetes_cluster_role.alb_ingress_controller.metadata.0.name
  }

  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.alb_ingress_controller.metadata.0.name
    namespace = kubernetes_service_account.alb_ingress_controller.metadata.0.namespace
  }
}

resource "kubernetes_deployment" "alb_ingress_controller" {
  metadata {
    name = "${var.kubernetes_resources_name_prefix}alb-ingress-controller"
    namespace = var.kubernetes_namespace
    labels = local.kubernetes_resources_labels
  }

  spec {
    replicas = 1

    selector {
      match_labels = local.kubernetes_deployment_labels_selector
    }

    template {
      metadata {
        labels = local.kubernetes_deployment_labels
        annotations = var.kubernetes_deployment_annotations
      }

      spec {
        service_account_name = kubernetes_service_account.alb_ingress_controller.metadata.0.name

        container {
          image = local.kubernetes_deployment_image
          name = "alb-ingress-controller"

          args = local.kubernetes_deployment_container_args

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

        node_selector = var.kubernetes_deployment_node_selector
      }
    }
  }
}
