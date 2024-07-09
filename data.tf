data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_name
}

data "aws_vpc" "vpc" {
  id = data.aws_eks_cluster.cluster.vpc_config[0].vpc_id
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = data.aws_eks_cluster.cluster.vpc_config[*].vpc_id
  }

  filter {
    name = "tag:Name"
    values = [
      "*private*",
      "*Private*"
    ]
  }
}

data "aws_region" "current" {}
