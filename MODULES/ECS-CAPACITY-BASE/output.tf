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