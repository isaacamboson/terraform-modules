output "autoscaling_grp" {
  value = aws_autoscaling_group.autoscaling_group.id
}

output "aws_launch_template" {
  value = aws_launch_template.app-launch-temp.id
}
