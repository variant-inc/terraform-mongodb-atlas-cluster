
resource "mongodbatlas_privatelink_endpoint" "pe" {
  project_id    = mongodbatlas_project.project.id
  provider_name = var.provider_name
  region        = var.region
}

resource "mongodbatlas_privatelink_endpoint_service" "pe_service" {
  project_id          = mongodbatlas_privatelink_endpoint.pe.project_id
  private_link_id     = mongodbatlas_privatelink_endpoint.pe.id
  endpoint_service_id = aws_vpc_endpoint.mongodb_vpce.id
  provider_name       = "AWS"
}

resource "aws_vpc_endpoint" "mongodb_vpce" {
  service_name       = mongodbatlas_privatelink_endpoint.pe.endpoint_service_name
  vpc_endpoint_type  = "Interface"
  vpc_id             = data.aws_eks_cluster.cluster.vpc_config[0].vpc_id
  security_group_ids = [module.mongodb_interface_sg.security_group_id]
  subnet_ids         = data.aws_subnets.subnets.ids
  tags = {
    Name   = mongodbatlas_privatelink_endpoint.pe.endpoint_service_name,
    region = var.region
  }
}

module "mongodb_interface_sg" {
  #checkov:skip=CKV_TF_1:Ensure Terraform module sources use a commit hash
  source              = "terraform-aws-modules/security-group/aws"
  version             = "~> 5.0"
  name                = "mongodb-interface-endpoint"
  description         = "Security group for mongodb interface-endpoints open within VPC"
  vpc_id              = data.aws_eks_cluster.cluster.vpc_config[0].vpc_id
  ingress_cidr_blocks = data.aws_vpc.vpc.cidr_block_associations[*].cidr_block
  ingress_rules       = ["all-tcp"]
}


resource "mongodbatlas_project_ip_access_list" "cidr" {

  for_each = {
    for cidr in local.cidr_block :
    cidr => cidr
  }
  project_id = mongodbatlas_project.project.id
  cidr_block = each.value
  comment    = "CIDR Block ${each.value}"
}
