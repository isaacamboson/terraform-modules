#creating aws application loadbalancer, target group and lb http listener

resource "aws_lb" "lb" {
  name                             = "${var.project_name}-load-balancer"
  subnets                          = var.pub_subnets
  security_groups                  = [var.lb_security_group]
  internal                         = false
  load_balancer_type               = "application"
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
}

#receiving all incoming traffic from the internet to the LB through the listener
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn           = aws_lb.lb.arn
  port                        = var.TG_Components["port"]
  protocol                    = var.TG_Components["protocol"]

  default_action {
    type                      = "forward"
    target_group_arn          = aws_lb_target_group.app-tg.arn
  }
}

#redirecting all incoming traffic from LB to the target group
resource "aws_lb_target_group" "app-tg" {
  name                        = "${var.project_name}-app-tg"
  port                        = var.TG_Components["port"]
  protocol                    = var.TG_Components["protocol"]
  vpc_id                      = var.vpc_main_id

  deregistration_delay        = 120

  health_check {
    healthy_threshold         = var.TG_Components["healthy_threshold"]
    unhealthy_threshold       = var.TG_Components["unhealthy_threshold"]
    timeout                   = var.TG_Components["timeout"]
    protocol                  = var.TG_Components["protocol"]
    interval                  = var.TG_Components["interval"]
    matcher                   = var.TG_Components["matcher"]    #HTTP status code matcher for healthcheck
    path                      = var.TG_Components["path"]       #Endpoint for ALB healthcheck
    port                      = var.TG_Components["traffic_port"]
  }
}