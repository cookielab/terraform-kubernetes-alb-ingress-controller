resource "kubernetes_service_account" "alb_ingress_controller" {
  metadata {
    name = var.kubernetes_service_account_name
    namespace = var.kubernetes_namespace
    labels = {
      "app.kubernetes.io/name" = "tf-aws-kube-alb-ingress-controller"
    }
  }

  automount_service_account_token = true
}

resource "kubernetes_cluster_role" "alb_ingress_controller" {
  metadata {
    name = var.kubernetes_cluster_role_name
    labels = {
      "app.kubernetes.io/name" = "tf-aws-kube-alb-ingress-controller"
    }
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
    name = var.kubernetes_cluster_role_binding_name
    labels = {
      "app.kubernetes.io/name" = "tf-aws-kube-alb-ingress-controller"
    }
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
