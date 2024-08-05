
variable "ami_id" {}
variable "env" {}
variable "default_vpc_id" {}

variable "PATH_TO_PRIVATE_KEY" {
  default = "my_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "my_key.pub"
}

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