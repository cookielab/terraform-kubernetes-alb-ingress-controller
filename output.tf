output "aws_iam_policy_arn" {
  value = length(aws_iam_policy.alb_ingress_controller) == 0 ? null : aws_iam_policy.alb_ingress_controller.0.arn
}

output "kubernetes_deployment" {
  value = "${kubernetes_deployment.alb_ingress_controller.metadata.0.namespace}/${kubernetes_deployment.alb_ingress_controller.metadata.0.name}"
}
