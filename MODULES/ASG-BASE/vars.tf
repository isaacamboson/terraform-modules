variable "project_name" {}

# variable "environment" {}

variable "stack_controls" {
  type = map(string)
  default = {}
}

variable "EC2_Components" {
  type = map(string)
  default = {}
}

variable "ASG_Components" {
  type = map(string)
  default = {}
}

variable "asg_private_subnets_id" {
    type = list(string)  
}

variable "aws_lb_target_group_arn" {}

variable "image_id" {}

variable "ecs_user_data" {}

variable "device_names" {}

variable "resource_tags" {}

variable "server_count" {}

variable "ec2_instance_role_profile_arn" {}

# variable "aws_ecs_cluster_name" {}

variable "ecs_sg_id" {}





