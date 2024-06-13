variable "org_id" {
  description = "MongoDB Atlas Org ID"
  type        = string
}

variable "provider_name" {
  description = "MongoDB Atlas Terraform Provider"
  type        = string
  default     = "AWS"
}

variable "version_release_system" {
  description = "MongoDB Version Release System"
  type        = string
  default     = "LTS"
  validation {
    condition     = can(regex("^LTS$|^CONTINUOUS$", var.version_release_system))
    error_message = "Invalid MongoDB version release system. Must be one of LTS or CONTINUOUS."
  }
}

variable "enable_backup" {
  description = "MongoDB Backup Snapshots would be enabled in AWS"
  type        = string
  default     = "true"
  validation {
    condition     = var.enable_backup == "true" || var.enable_backup == "false"
    error_message = "Invalid value for enable_backup. Must be either 'true' or 'false'."
  }
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
  description = "AWS Region for MongoDB Atlas cluster deployment"
  type        = string
  default     = "us-east-2"
  validation {
    condition     = can(regex("^(us|eu|ap|sa|ca|af)-(north|south|central|east|west|northeast|southeast|southwest|northwest)-\\d+$", var.region))
    error_message = "Invalid AWS region format. Must follow the format: <region>-<availability_zone>-<number> (e.g., us-east-1)."
  }
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
  type = object({
    min = string
    max = string
  })
  default = {
    max = "M30"
    min = "M10"
  }
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

variable "compute_scale_down_enabled" {
  description = "Enables or disables scaling down of compute resources."
  type        = bool
  default     = true
}

variable "node_count" {
  description = "Number of nodes in the MongoDB Atlas cluster."
  type        = number
  default     = 3
}

variable "tags" {
  type        = map(string)
  description = "Tags for mongodb atlas"
  default     = {}
}

variable "eks_cluster_name" {
  type        = string
  description = "Name of EKS Cluster name"
}

variable "ip_access_list" {
  type        = list(string)
  description = "List of IP addresses or CIDR blocks allowed to access the MongoDB Atlas cluster"
  validation {
    condition     = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}(?:\\/\\d{1,2})?$", var.ip_access_list[*]))
    error_message = "Invalid IP address or CIDR block format. Must be in the form of an IP address (e.g., '192.168.1.1') or CIDR notation (e.g., '192.168.1.0/24')."
  }
}
