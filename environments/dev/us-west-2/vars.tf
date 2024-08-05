variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}


variable "environment" {
  default = "dev"
}

variable "default_vpc_id" {
  default = "vpc-01f9d081aa9bbf727"
}

variable "system" {
  default = "Retail Reporting"
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
    "172.31.0.0/16"
  ]
}

variable "instance_type" {
  default = "t2.micro"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "my_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "my_key.pub"
}

variable "OwnerEmail" {
  default = "isaacamboson@gmail.com"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "stack-ami-image-1"
    us-west-2 = "ami-08c9fd1731fcfad47"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "subnet" {
  default = "subnet-0587be32196db71a6"
}

#subnet IDs
variable "subnet_ids" {
  type = list(string)
  default = [
    "subnet-0587be32196db71a6",
    "subnet-05bd17fd6dd2f3de6",
    "subnet-0f03ac2bdd0987683",
    "subnet-0e457585d941f555d"
    # "subnet-0a1919939855f7719",
    # "subnet-0a42cd4d9757fb272"
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

variable "backup" {
  default = "yes"
}