variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}

variable "environment" {
  default = "dev"
}

variable "OwnerEmail" {
  default = "isaacamboson@gmail.com"
}

variable "system" {
  default = "Retail Reporting"
}

variable "backup" {
  default = "yes"
}

variable "subsystem" {
  default = "CliXX"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-stack-1.0"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "stack_controls" {
  type = map(string)
  default = {
    ec2_create = "Y"
    rds_create = "Y"
  }
}

variable "EC2_Components" {
  type = map(string)
  default = {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = true
    encrypted             = "true"
    instance_type         = "t2.micro"
  }
}

variable "vpc_cidr" {
  type    = string
  default = "10.1.0.0/16"
}

variable "project_name" {
  type    = string
  default = "clixx"
}

variable "availability_zone" {
  default = [
    "us-east-1a",
    "us-east-1b"
  ]
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = [
    "10.1.2.0/23", # 510 hosts   - bastion, load balancer
    "10.1.4.0/23"  # 510 hosts   - bastion, load balancer
  ]
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = [
    "10.1.0.0/24", # 254 hosts   - Application Server
    "10.1.1.0/24", # 254 hosts   - Application Server
    "10.1.8.0/22", # 1022 hosts  - RDS
    "10.1.12.0/22" # 1022 hosts  - RDS
  ]
}

variable "server_count" {
  description = "number of servers to be built"
  default = 4
}

variable "access_ports_public" {
  description = "various ingress ports allowed on the security group for load balancer and bastion"
  type    = list(number)
  default = [22, 80, 443]
}

variable "access_ports_private" {
  type    = list(number)
  default = [22, 80, 443]
}
