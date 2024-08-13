output "alb_lb_id" {
  value = aws_lb.lb.id
}

output "aws_lb_listener_id" {
  value = aws_lb_listener.app_listener.id
}

output "aws_lb_target_group_id" {
  value = aws_lb_target_group.app-tg.id
}