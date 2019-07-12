variable "kubernetes_cluster_name" {
  type = string
  description = "Kubernetes cluster name."
}

variable "aws_vpc_id" {
  type = string
  description = "AWS VPC ID."
}

variable "aws_region" {
  type = string
  description = "AWS region."
}

variable "aws_create_policy" {
  type = bool
  default = true
  description = "Do you want to create IAM policy?"
}

variable "aws_role_for_policy" {
  type = string
  default = null
  description = "AWS role name for attaching IAM policy"
}

variable "kubernetes_namespace" {
  type = string
  default = "kube-system"
  description = "Kubernetes namespace to deploy ALB ingress controller."
}

variable "kubernetes_namespace_create" {
  type = bool
  default = false
  description = "Do you want to create kubernetes namespace?"
}

variable "kubernetes_service_account_name" {
  type = string
  default = "alb-ingress-controller"
  description = "Kubernetes service account name."
}

variable "kubernetes_cluster_role_name" {
  type = string
  default = "alb-ingress-controller"
  description = "Kubernetes cluster role name."
}

variable "kubernetes_cluster_role_binding_name" {
  type = string
  default = "alb-ingress-controller"
  description = "Kubernetes cluster role binding name."
}

variable "kubernetes_deployment_name" {
  type = string
  default = "alb-ingress-controller"
  description = "Kubernetes deployment name."
}