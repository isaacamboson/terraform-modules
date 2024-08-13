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

output "aws_ecs_capacity_provider_id" {
  value = aws_ecs_capacity_provider.cas.id
}

output "aws_ecs_cluster_capacity_providers_id" {
  value = aws_ecs_cluster_capacity_providers.cas.id
}

output "aws_appautoscaling_target_id" {
  value = aws_appautoscaling_target.ecs_target.id
}

output "aws_appautoscaling_policy_cpu_id" {
  value = aws_appautoscaling_policy.ecs_cpu_policy.id
}

output "aws_appautoscaling_policy_memory_id" {
  value = aws_appautoscaling_policy.ecs_memory_policy.id
}

