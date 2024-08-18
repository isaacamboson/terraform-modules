variable "project_name" {}

variable "environment" {}

variable "container_definitions" {}

variable "ECS_Service_Components" {
  type = map(string)
  default = {}
}

variable "aws_lb_target_group_arn" {}

variable "aws_db_instance_depends_on" {}