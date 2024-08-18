output "alb_lb_id" {
  value = aws_lb.lb.id
}

output "alb_lb_dns_name" {
  value = aws_lb.lb.dns_name  
}

output "alb_lb_zone_id" {
  value = aws_lb.lb.zone_id
}

output "aws_lb_listener_id" {
  value = aws_lb_listener.app_listener.id
}

output "aws_lb_target_group_id" {
  value = aws_lb_target_group.app-tg.id
}

output "aws_lb_target_group_arn" {
  value = aws_lb_target_group.app-tg.arn
}

