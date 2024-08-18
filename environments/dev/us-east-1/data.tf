
# data "aws_subnets" "stack_sub" {
#   filter {
#     name   = "vpc-id"
#     values = [var.default_vpc_id]
#   }
# }

# data "aws_subnet" "stack_sub" {
#   for_each = toset(data.aws_subnets.stack_sub.ids)
#   id       = each.value
# }

data "aws_ami" "stack_ami" {
  owners      = ["self"]
  name_regex  = "^ami-stack*"
  most_recent = true

  filter {
    name   = "name"
    values = ["ami-stack-*"]
  }
}

data "aws_ami" "ecs-optimized" {
  owners      = ["679593333241"]
  # name_regex  = "^Galaxys Amazon ECS-Optimized Amazon Linux 2 (AL2)*"
  # name_regex  = "^Amazon ECS-Optimized Amazon Linux 2 AMI*"
  # most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-02e926f32f5248569"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

data "aws_secretsmanager_secret_version" "creds" {
  # fill in the name you gave the secret
  secret_id = "creds"
}

data "aws_route53_zone" "stack_isaac_zone" {
  name         = "stack-isaac.com." # Notice the dot!!!
  private_zone = false
}