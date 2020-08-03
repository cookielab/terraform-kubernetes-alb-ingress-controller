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

variable "kubernetes_namespace" {
  type = string
  default = "kube-system"
  description = "Kubernetes namespace to deploy external dns."
}

variable "kubernetes_namespace_create" {
  type = bool
  default = false
  description = "Do you want to create kubernetes namespace?"
}

variable "kubernetes_resources_name_prefix" {
  type = string
  default = ""
  description = "Prefix for kubernetes resources name. For example `tf-module-`"
}

variable "kubernetes_resources_labels" {
  type = map(string)
  default = {}
  description = "Additional labels for kubernetes resources."
}

variable "kubernetes_deployment_image_registry" {
  type = string
  default = "docker.io/amazon/aws-alb-ingress-controller"
}

variable "kubernetes_deployment_image_tag" {
  type = string
  default = "v1.1.4"
}

variable "kubernetes_deployment_annotations" {
  type = map(string)
  default = {}
  description = "Annotations for pod template"
}

variable "kubernetes_deployment_node_selector" {
  type = map(string)
  default = {}
  description = "Node selectors for kubernetes deployment"
}

variable "aws_create_iam_policy" {
  type = bool
  default = true
  description = "Do you want to create IAM policy?"
}

variable "aws_iam_policy_name" {
  type = string
  default = "KubernetesAlbIngressController"
  description = "Name of AWS IAM policy."
}

variable "aws_iam_role_for_policy" {
  type = string
  default = null
  description = "AWS role name for attaching IAM policy"
}
