locals {
  kube_container_args = [
    "--ingress-class=alb",
    "--cluster-name=${var.kubernetes_cluster_name}",
    "--aws-vpc-id=${var.aws_vpc_id}",
    "--aws-region=${var.aws_region}",
  ]
}