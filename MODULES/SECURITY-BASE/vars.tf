variable "project_name" {}
variable "vpc_main_id" {}
variable "access_ports_public" {
    type = list
    default = []
}
variable "access_ports_private" {
    type = list
    default = []
}
variable "resource_tags" {
  type = map(string)
  default = {}
}



