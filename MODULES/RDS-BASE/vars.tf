
variable "project_name" {}

variable "environment" {}

# variable "db_private_subnets" {}

variable "rds_private_subnets_id" {}

variable "stack_controls" {
  type = map(string)
  default = {}
}

variable "DB_Components" {
  type = map(string)
  default = {}
}

variable "resource_tags" {
  type = map(string)
  default = {}
}

variable "identifier" {}

variable "snapshot_identifier" {}

variable "rds_security_group_ids" {}

