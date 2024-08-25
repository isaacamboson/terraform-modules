
variable "ami_id" {}
variable "env" {}

#subnet IDs
variable "subnet_ids" {
  type = list(string)
  default = []
}

variable "stack_controls" {
  type = map(string)
  default = {}
}

variable "EC2_Components" {
  type = map(string)
  default = {}
}

variable "resource_tags" {
  type = map(string)
  default = {}
}

variable "server_count" {}

variable "public_subnets_id" {}

variable "alb_bastion_sg_id" {}

variable "user_data_bootstrap" {}

# variable "availability_zone" {
#   type = list(string)
# }