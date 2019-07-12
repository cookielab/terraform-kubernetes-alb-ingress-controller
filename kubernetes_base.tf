resource "kubernetes_namespace" "alb_ingress_controller" {
  count = var.kubernetes_namespace_create ? 1 : 0

  metadata {
    name = var.kubernetes_namespace
  }
}
