# variable "AWS_ACCESS_KEY" {}
# variable "AWS_SECRET_KEY" {}
# variable "AWS_REGION" {}

variable "ami_id" {}
variable "env" {}
variable "default_vpc_id" {}

# variable "instance_type" {
#   # default = "t2.micro"
# }


# variable "system" {
#   default = "Retail Reporting"
# }

# variable "subsystem" {
#   default = "CliXX"
# }

# variable "subnets_cidrs" {
#   type = list(string)
#   default = [
#     "172.31.80.0/20"
#   ]
# }

variable "PATH_TO_PRIVATE_KEY" {
  default = "my_key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "my_key.pub"
}

# variable "OwnerEmail" {
#   default = "isaacamboson@gmail.com"
# }

# variable "AMIS" {
#   type = map(string)
#   default = {
#     us-east-1 = "ami-000ad002570abbe61"
#     us-west-2 = "ami-06b94666"
#     eu-west-1 = "ami-844e0bf7"
#   }
# }

# variable "subnet" {
#   default = "subnet-0237ec1aa4ab23ba1"
# }

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

# variable "backup" {
#   default = "yes"
# }

# variable "resource_tags" {
#   type = map(string)
#   default = {}
# }