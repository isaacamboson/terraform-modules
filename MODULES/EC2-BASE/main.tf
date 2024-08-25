locals {
  ServerPrefix = ""
}

#creating two EIPs for AWS instances
resource "aws_eip" "eip_aws_instance" {
  count = length(var.public_subnets_id)
}

#associating EIPs to AWS instances in AZ-A and AZ-B
resource "aws_eip_association" "eip_assoc_bastion" {
  count         = length(var.public_subnets_id)
  instance_id   = element(aws_instance.server.*.id, count.index)
  allocation_id = element(aws_eip.eip_aws_instance.*.id, count.index)
}

#Creates server instances
resource "aws_instance" "server" {
  count                       = var.stack_controls["ec2_create"] == "Y" ? var.server_count : 0
  ami                         = var.ami_id
  instance_type               = var.EC2_Components["instance_type"]
  vpc_security_group_ids      = [var.alb_bastion_sg_id]
  user_data                   = var.user_data_bootstrap
  key_name                    = "private-key-kp"
  subnet_id                   = element(var.public_subnets_id, count.index)
  # associate_public_ip_address = true

  
  root_block_device {
    volume_type           = var.EC2_Components["volume_type"]
    volume_size           = var.EC2_Components["volume_size"]
    delete_on_termination = var.EC2_Components["delete_on_termination"]
    encrypted             = var.EC2_Components["encrypted"]
  }

  tags = merge({Name = "${local.ServerPrefix != "" ? local.ServerPrefix : "Application_Server_Aut_"}${count.index}"}, var.resource_tags) 

}



