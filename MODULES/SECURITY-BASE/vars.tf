variable "project_name" {}

variable "vpc_main_id" {}

variable "access_ports_public" {
    type = list(number)
    default = []
}

variable "app_sg_access_ports" {
    type = list(number)
    default = []
}

variable "ecs_sg_access_ports" {
    type = list(number)
    default = []
}

variable "rds_sg_access_ports" {
    type = list(number)
    default = []
}

variable "efs_sg_access_ports" {
    type = list(number)
    default = []
}

variable "resource_tags" {
  type = map(string)
  default = {}
}


