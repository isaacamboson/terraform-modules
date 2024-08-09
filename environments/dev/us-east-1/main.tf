locals {
  ServerPrefix = ""
}

# module call
module "CORE-INFO" {
  # source = "../../../MODULES/CORE-INFO"
  source              = "github.com/isaacamboson/terraform-modules/MODULES/CORE-INFO"
  required_tags = {
    Environment       = var.environment,
    OwnerEmail        = var.OwnerEmail,
    System            = var.system,
    Backup            = var.backup,
    Region            = var.AWS_REGION
  }
}

module "VPC-BASE" {
  # source               = "../../../MODULES/VPC-BASE"
  source               = "github.com/isaacamboson/terraform-modules/MODULES/VPC-BASE"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  availability_zone    = var.availability_zone
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "SECURITY-BASE" {
  # source               = "../../../MODULES/SECURITY-BASE"
  source               = "github.com/isaacamboson/terraform-modules/MODULES/SECURITY-BASE"
  project_name         = var.project_name
  vpc_main_id          = module.VPC-BASE.vpc_main_id
  access_ports_public  = var.access_ports_public
  access_ports_private = var.access_ports_private
  resource_tags        = module.CORE-INFO.all_resource_tags
}

module "EC2-BASE" {
  # source = "../../../MODULES/EC2-BASE"
  source                = "github.com/isaacamboson/terraform-modules/MODULES/EC2-BASE"
  server_count          = var.server_count
  ami_id                = data.aws_ami.stack_ami.id
  stack_controls        = var.stack_controls
  EC2_Components        = var.EC2_Components
  alb_bastion_sg_id     = module.SECURITY-BASE.alb_bastion_sg_id
  env                   = var.environment
  public_subnets_id     = module.VPC-BASE.public_subnets_id
  resource_tags         = module.CORE-INFO.all_resource_tags
}


