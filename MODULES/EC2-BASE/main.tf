locals {
  ServerPrefix = ""
}

#Creates server instances
resource "aws_instance" "server" {
  count                   = var.stack_controls["ec2_create"] == "Y" ? var.server_count : 0
  ami                     = var.ami_id
  instance_type           = var.EC2_Components["instance_type"]
  vpc_security_group_ids  = [var.alb_bastion_sg_id]
  user_data               = var.user_data_bootstrap
  # user_data               = data.template_file.bootstrap.rendered
  key_name                = "private-key-kp"
  subnet_id               = element(var.public_subnets_id, count.index)
  root_block_device {
    volume_type           = var.EC2_Components["volume_type"]
    volume_size           = var.EC2_Components["volume_size"]
    delete_on_termination = var.EC2_Components["delete_on_termination"]
    encrypted             = var.EC2_Components["encrypted"]
  }

  tags = merge({Name = "${local.ServerPrefix != "" ? local.ServerPrefix : "Application_Server_Aut_"}${count.index}"}, var.resource_tags) 

}



