output "autoscaling_grp_id" {
  value = aws_autoscaling_group.autoscaling_group.id
}

output "autoscaling_grp_arn" {
  value = aws_autoscaling_group.autoscaling_group.arn
}

output "aws_launch_template_id" {
  value = aws_launch_template.app-launch-temp.id
}
