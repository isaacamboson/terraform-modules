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

variable "default_vpc_id" {
  default = "vpc-0da071fbb2608e526"
}

variable "subsystem" {
  default = "CliXX"
}

variable "availability_zone" {
  default = "us-east-1c"
}

variable "subnets_cidrs" {
  type = list(string)
  default = [
    "172.31.80.0/20"
  ]
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "my_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "my_key.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-stack-1.0"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "subnet" {
  default = "subnet-0237ec1aa4ab23ba1"
}

#subnet IDs
variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-0237ec1aa4ab23ba1",
    "subnet-009b56f7ed89b5b63",
    "subnet-0aa7125aef0e45ea5",
    "subnet-06014beebc5c0c2bd",
    "subnet-0a1919939855f7719",
    "subnet-0a42cd4d9757fb272"
  ]
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
