variable "project_name" {}

variable "environment" {}

variable "pub_subnets" {
    type = list()
}

variable "lb_security_group" {}

variable "TG_Components" {
    type = map(string)
}

variable "vpc_main_id" {}