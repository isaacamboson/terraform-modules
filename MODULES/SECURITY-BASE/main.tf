locals {
  ServerPrefix = ""
}

#security group for application load balancer and bastion servers (all in public subnets)
resource "aws_security_group" "alb_bastion_sg" {
  name   = "${var.project_name}-alb-bastion-sg"   
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

#security group for application in private subnet
resource "aws_security_group" "private_app_sg" {
  name        = "${var.project_name}-application-sg"
  vpc_id      = var.vpc_main_id
  
  dynamic "ingress" {
    for_each          = var.app_sg_access_ports
    content {   
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      description     = "Security group for app server in private subnet"
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

#security group for ECS 
resource "aws_security_group" "ecs_sg" {
  name        = "${var.project_name}-ecs-sg"
  vpc_id      = var.vpc_main_id
  
  dynamic "ingress" {
    for_each          = var.ecs_sg_access_ports
    content {   
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      description     = "Security group for ecs in private subnet"
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

  tags = merge({Name  = "${local.ServerPrefix != "" ? local.ServerPrefix : "ecs_security_grp"}"}, var.resource_tags)
}

#security group for RDS database 
resource "aws_security_group" "rds_sg" {
  name        = "${var.project_name}-rds-db-sg"
  vpc_id      = var.vpc_main_id
  
  dynamic "ingress" {
    for_each          = var.rds_sg_access_ports
    content {   
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      description     = "Security group for RDS DB in private subnet"
      security_groups = [aws_security_group.private_app_sg.id]
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

  tags = merge({Name  = "${local.ServerPrefix != "" ? local.ServerPrefix : "rds_db_security_grp"}"}, var.resource_tags)
}
