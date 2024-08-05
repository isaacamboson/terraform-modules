locals {
  ServerPrefix = ""
}

# module call
module "CORE-INFO" {
  source = "../../../MODULES/CORE-INFO"
  # source = "github.com/isaacamboson/terraform-modules/tree/main/MODULES/CORE-INFO"
  required_tags = {
    Environment = var.environment,
    OwnerEmail  = var.OwnerEmail,
    System      = var.system,
    Backup      = var.backup,
    Region      = var.AWS_REGION
  }
}

module "EC2-BASE" {
  count = var.stack_controls["ec2_create"] == "Y" ? 1 : 0
  source         = "../../../MODULES/EC2-BASE"
  # source         = "github.com/isaacamboson/terraform-modules/tree/main/MODULES/EC2-BASE"
  ami_id         = data.aws_ami.stack_ami.id
  stack_controls = var.stack_controls
  EC2_Components = var.EC2_Components
  default_vpc_id = var.default_vpc_id
  env            = var.environment
  subnet_ids     = var.subnet_ids
  resource_tags  = module.CORE-INFO.all_resource_tags
}




