output "alb_bastion_sg_id" {
  value = aws_security_group.alb_bastion_sg.id
}

output "private_app_sg_id" {
  value = aws_security_group.private_app_sg
}
