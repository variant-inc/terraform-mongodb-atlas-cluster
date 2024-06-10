variable "org_id" {
  description = "MongoDB Atlas Org ID"
  type        = string
  default     = "643592c6bfd6bd1c5a614465"
}

variable "provider_name" {
  description = "MongoDB Atlas Terraform Provider"
  type        = string
  default     = "AWS"
}

variable "backup" {
  description = "MongoDB Backup Snapshots would be enabled in AWS"
  type        = string
  default     = "true"
}

variable "mongo_db_major_version" {
  description = "Required MongoDB Server Version"
  type        = string
  default     = "7.0"
}

variable "project" {
  description = "MongoDB Atlas Project Name where your clusters would deploy"
  type        = string
}

variable "pit_enabled" {
  description = "cluster uses Continuous Cloud Backup"
  type        = string
}

variable "name" {
  description = "Name of the MongoDB Atlas cluster"
  type        = string
}

variable "region" {
  description = "Specifies the AWS region where the MongoDB Atlas cluster will be deployed"
  type        = string
  default     = "us-east-2"
}

variable "read_only_nodes" {
  description = "Number of read-only nodes in the cluster."
  type        = number
  default     = 0
}

variable "num_shards" {
  description = "Sets the number of shards for a sharded cluster."
  type        = number
  default     = 1
}

variable "instance_size" {
  description = "Specifies the instance size (e.g., M10, M20, etc.)."
  type        = string
  default     = "M10"
}

variable "disk_gb_enabled" {
  description = "Enables or disables disk auto-scaling"
  type        = bool
  default     = true
}

variable "compute_enabled" {
  description = "Enables or disables compute resources."
  type        = bool
  default     = true
}

variable "compute_max_instance_size" {
  description = "Specifies the maximum instance size for compute resources."
  type        = string
  default     = "M40"
}

variable "compute_scale_down_enabled" {
  description = "Enables or disables scaling down of compute resources."
  type        = bool
  default     = true
}

variable "compute_min_instance_size" {
  description = "Specifies the minimum instance size for compute resources."
  type        = string
  default     = "M10"
}

variable "node_count" {
  description = "Number of nodes in the MongoDB Atlas cluster."
  type        = number
  default     = 3
}

variable "username" {
  description = "Root Username"
  type        = string
  default     = "root"
}

variable "enable_prometheus" {
  description = "Enable prometheus third party integration"
  type        = bool
  default     = false
}
