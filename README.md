# Terraform module for Kubernetes ALB Ingress Controller on AWS

> [!WARNING]  
> This module is no longer maintained. We recommend switching to [Helm](https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller).

This module deploys [ALB Ingress Controller](https://kubernetes-sigs.github.io/aws-alb-ingress-controller/) for AWS to your Kubernetes cluster.

## Usage

```terraform
provider "kubernetes" {
  # your kubernetes provider config
}

provider "aws" {
  # your aws provider config
}

data "aws_iam_role" "kubernetes_worker_node" {
  name = "kube-clb-main-wg-primary"
}

module "kubernetes_dashboard" {
  source = "cookielab/alb-ingress-controller/kubernetes"
  version = "0.9.0"

  kubernetes_cluster_name = var.kube_cluster_name
  aws_vpc_id = "vpc-clb-k8s-main"
  aws_region = "eu-west-1"
  
  aws_iam_role_for_policy = data.aws_iam_role.kubernetes_worker_node.name
}
```