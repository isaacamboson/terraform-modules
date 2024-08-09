locals {
  ServerPrefix = ""
}

resource "aws_security_group" "alb_bastion_sg" {
  name   = "${var.project_name}-public-sg"   
  vpc_id = var.vpc_main_id

  dynamic "ingress" {
    for_each           = var.access_ports_public
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      description      = "Allow all request from anywhere"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  timeouts {
    delete = "2m"
  }

  lifecycle {
    create_before_destroy = true
  }

 tags = merge({Name  = "${local.ServerPrefix != "" ? local.ServerPrefix : "pub_security_grp"}"}, var.resource_tags)
}

resource "aws_security_group" "private_app_sg" {
  name        = "${var.project_name}-private-sg"
  vpc_id      = var.vpc_main_id
  
  dynamic "ingress" {
    for_each          = var.access_ports_private
    content {   
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      description     = "Security group for private subnet Servers"
      security_groups = [aws_security_group.alb_bastion_sg.id]
      self            = true
    } 
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  timeouts {
    delete = "2m"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge({Name  = "${local.ServerPrefix != "" ? local.ServerPrefix : "private_security_grp"}"}, var.resource_tags)
}

