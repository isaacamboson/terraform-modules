# locals {
#   ServerPrefix = ""
# }

# module call
module "CORE-INFO" {
  source = "../../../MODULES/CORE-INFO"
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
  ami_id         = data.aws_ami.stack_ami.id
  stack_controls = var.stack_controls
  EC2_Components = var.EC2_Components
  default_vpc_id = var.default_vpc_id
  env            = var.environment
  subnet_ids     = var.subnet_ids
  resource_tags  = module.CORE-INFO.all_resource_tags
}

# # Declare Key Pair
# resource "aws_key_pair" "Stack_KP" {
#   key_name   = "stackkp"
#   public_key = file(var.PATH_TO_PUBLIC_KEY)
# }

# resource "aws_security_group" "stack-sg" {
#   vpc_id      = var.default_vpc_id
#   name        = "Stack-WebDMZ"
#   description = "Stack IT Security Group For CliXX System"
# }

# resource "aws_security_group_rule" "ssh" {
#   security_group_id = aws_security_group.stack-sg.id
#   type              = "ingress"
#   protocol          = "tcp"
#   from_port         = 22
#   to_port           = 22
#   cidr_blocks       = ["0.0.0.0/0"]
# }

# # resource "aws_instance" "server" {
# #   count = length(var.subnet_ids)
# #   ami                     = data.aws_ami.stack_ami.id
# #   instance_type           = var.instance_type
# #   vpc_security_group_ids  = [aws_security_group.stack-sg.id]
# #   user_data               = data.template_file.bootstrap.rendered
# #   key_name                = aws_key_pair.Stack_KP.key_name
# #   subnet_id               = var.subnet_ids[count.index]
# #  root_block_device {
# #     volume_type           = "gp2"
# #     volume_size           = 30
# #     delete_on_termination = true
# #     encrypted= "true"
# #   }
# #   tags = {
# #    #Name = "Application_Server_Aut-${count.index}"
# #    Name  = "${local.ServerPrefix != "" ? local.ServerPrefix : "Application_Server_Aut_"}${count.index}"
# #    Environment = var.environment
# #    OwnerEmail = var.OwnerEmail
# # }
# # }

# resource "aws_instance" "server" {
#   count                  = var.stack_controls["ec2_create"] == "Y" ? 1 : 0
#   ami                    = data.aws_ami.stack_ami.id
#   instance_type          = var.EC2_Components["instance_type"]
#   vpc_security_group_ids = [aws_security_group.stack-sg.id]
#   user_data              = data.template_file.bootstrap.rendered
#   key_name               = aws_key_pair.Stack_KP.key_name
#   subnet_id              = var.subnet_ids[count.index]
#   root_block_device {
#     volume_type           = var.EC2_Components["volume_type"]
#     volume_size           = var.EC2_Components["volume_size"]
#     delete_on_termination = var.EC2_Components["delete_on_termination"]
#     encrypted             = var.EC2_Components["encrypted"]
#   }
#   tags = merge({Name = "${local.ServerPrefix != "" ? local.ServerPrefix : "Application_Server_Aut_"}${count.index}"}, module.CORE-INFO.all_resource_tags)
# }


