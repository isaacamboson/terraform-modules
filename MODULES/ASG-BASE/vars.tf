variable "project_name" {}

variable "environment" {}

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

variable "asg_private_subnets" {
    type = list()  
}

variable "aws_lb_target_group_id" {}

variable "image_id" {}

variable "user_data_filepath" {}

variable "device_names" {}

variable "resource_tags" {}

variable "server_count" {}







