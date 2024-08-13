output "aws_ecs_cluster" {
  value = aws_ecs_cluster.ecs_cluster.id
}

output "aws_ecs_task_definition" {
  value = aws_ecs_task_definition.ecs-def.id
}

output "aws_ecs_service" {
  value = aws_ecs_service.ecs-service.id
}

output "aws_ecs_capacity_provider" {
  value = aws_ecs_capacity_provider.cas.id
}

output "aws_ecs_cluster_capacity_providers" {
  value = aws_ecs_cluster_capacity_providers.cas.id
}

output "aws_appautoscaling_target" {
  value = aws_appautoscaling_target.ecs_target.id
}

output "aws_appautoscaling_policy_cpu" {
  value = aws_appautoscaling_policy.ecs_cpu_policy.id
}

output "aws_appautoscaling_policy_memory" {
  value = aws_appautoscaling_policy.ecs_memory_policy.id
}

