locals {
  kubernetes_resources_labels = merge({
    "cookielab.io/terraform-module" = "aws-kube-alb-ingress-controller",
  }, var.kubernetes_resources_labels)

  kubernetes_deployment_labels_selector = {
    "cookielab.io/deployment" = "aws-kube-alb-ingress-controller-tf-module",
  }

  kubernetes_deployment_labels = merge(local.kubernetes_deployment_labels_selector, local.kubernetes_resources_labels)

  kubernetes_deployment_image = "${var.kubernetes_deployment_image_registry}:${var.kubernetes_deployment_image_tag}"

  kubernetes_deployment_container_args = [
    "--ingress-class=alb",
    "--cluster-name=${var.kubernetes_cluster_name}",
    "--aws-vpc-id=${var.aws_vpc_id}",
    "--aws-region=${var.aws_region}",
  ]
}