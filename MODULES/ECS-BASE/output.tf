output "aws_ecs_cluster_id" {
  value = aws_ecs_cluster.ecs_cluster.id
}

output "aws_ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}

output "aws_ecs_task_definition_id" {
  value = aws_ecs_task_definition.ecs-def.id
}

output "aws_ecs_service_id" {
  value = aws_ecs_service.ecs-service.id
}

output "aws_ecs_service_name" {
  value = aws_ecs_service.ecs-service.name
}

output "ec2_instance_role_profile_arn" {
  value = aws_iam_instance_profile.ec2_instance_role_profile.arn
}

