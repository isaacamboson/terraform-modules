variable "project_name" {}

variable "environment" {}

variable "autoscaling_grp_arn" {}

variable "ECS_Capacity_Components" {
  type = map(string)
  default = {}
}

variable "ECS_Appautoscaling_Components" {
  type = map(string)
  default = {}
}

variable "aws_ecs_cluster_name" {}

variable "aws_ecs_service_name" {}