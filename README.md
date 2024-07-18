# terraform-mongodb-atlas-cluster

<!-- markdownlint-disable MD033 MD013 MD041 -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_mongodbatlas"></a> [mongodbatlas](#requirement\_mongodbatlas) | ~> 1.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mongodb_interface_sg"></a> [mongodb\_interface\_sg](#module\_mongodb\_interface\_sg) | terraform-aws-modules/security-group/aws | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_policy.policy_att](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_policy) | resource |
| [aws_secretsmanager_secret_version.secret_val](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_vpc_endpoint.mongodb_vpce](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [mongodbatlas_advanced_cluster.cluster](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/advanced_cluster) | resource |
| [mongodbatlas_privatelink_endpoint.pe](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/privatelink_endpoint) | resource |
| [mongodbatlas_privatelink_endpoint_service.pe_service](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/privatelink_endpoint_service) | resource |
| [mongodbatlas_project.project](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project) | resource |
| [mongodbatlas_project_ip_access_list.cidr](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/project_ip_access_list) | resource |
| [mongodbatlas_x509_authentication_database_user.auth_db](https://registry.terraform.io/providers/mongodb/mongodbatlas/latest/docs/resources/x509_authentication_database_user) | resource |
| [tls_private_key.ca_certificate](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [tls_self_signed_cert.cert](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/self_signed_cert) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_iam_policy_document.policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnets.subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_configuration"></a> [advanced\_configuration](#input\_advanced\_configuration) | Advanced configuration settings for MongoDB | `map(any)` | n/a | yes |
| <a name="input_aws_org_id"></a> [aws\_org\_id](#input\_aws\_org\_id) | AWS Org ID | `string` | n/a | yes |
| <a name="input_compute_enabled"></a> [compute\_enabled](#input\_compute\_enabled) | Enables or disables compute resources. | `bool` | `true` | no |
| <a name="input_compute_scale_down_enabled"></a> [compute\_scale\_down\_enabled](#input\_compute\_scale\_down\_enabled) | Enables or disables scaling down of compute resources. | `bool` | `true` | no |
| <a name="input_disk_gb_enabled"></a> [disk\_gb\_enabled](#input\_disk\_gb\_enabled) | Enables or disables disk auto-scaling | `bool` | `true` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of EKS Cluster name | `string` | n/a | yes |
| <a name="input_enable_backup"></a> [enable\_backup](#input\_enable\_backup) | MongoDB Backup Snapshots would be enabled in AWS | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment Name | `string` | n/a | yes |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | Specifies the instance size (e.g., M10, M20, etc.). | <pre>object({<br>    min = string<br>    max = string<br>  })</pre> | n/a | yes |
| <a name="input_ip_access_list"></a> [ip\_access\_list](#input\_ip\_access\_list) | List of IP addresses or CIDR blocks allowed to access the MongoDB Atlas cluster | `list(string)` | n/a | yes |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ID of the AWS KMS key used to encrypt secrets managed by Secrets Manager. | `string` | n/a | yes |
| <a name="input_mongo_db_major_version"></a> [mongo\_db\_major\_version](#input\_mongo\_db\_major\_version) | Required MongoDB Server Version | `string` | `"7.0"` | no |
| <a name="input_mongo_org_id"></a> [mongo\_org\_id](#input\_mongo\_org\_id) | MongoDB Atlas Org ID | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the MongoDB Atlas cluster | `string` | n/a | yes |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Number of nodes in the MongoDB Atlas cluster. | `number` | `3` | no |
| <a name="input_num_shards"></a> [num\_shards](#input\_num\_shards) | Sets the number of shards for a sharded cluster. | `number` | `1` | no |
| <a name="input_pit_enabled"></a> [pit\_enabled](#input\_pit\_enabled) | cluster uses Continuous Cloud Backup | `string` | `"false"` | no |
| <a name="input_project"></a> [project](#input\_project) | MongoDB Atlas Project Name where your clusters would deploy | `string` | n/a | yes |
| <a name="input_provider_name"></a> [provider\_name](#input\_provider\_name) | MongoDB Atlas Terraform Provider | `string` | `"AWS"` | no |
| <a name="input_read_only_nodes"></a> [read\_only\_nodes](#input\_read\_only\_nodes) | Number of read-only nodes in the cluster. | `number` | `0` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources | `map(any)` | n/a | yes |
| <a name="input_termination_protection_enabled"></a> [termination\_protection\_enabled](#input\_termination\_protection\_enabled) | Enable/Disable Termination Protection. | `bool` | `true` | no |
| <a name="input_version_release_system"></a> [version\_release\_system](#input\_version\_release\_system) | MongoDB Version Release System. Must be one of LTS or CONTINUOUS. | `string` | `"LTS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ca_secret_arn"></a> [ca\_secret\_arn](#output\_ca\_secret\_arn) | Mongodb CA Certificate Secret ARN |
| <a name="output_clusterinfo"></a> [clusterinfo](#output\_clusterinfo) | MongoDB Cluster Info |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
