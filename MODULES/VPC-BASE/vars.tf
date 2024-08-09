variable "vpc_cidr" {}
variable "project_name" {}
variable "availability_zone" {}
variable "public_subnet_cidrs" {
    type = list(string)
}
variable "private_subnet_cidrs" {
    type = list(string)
}


