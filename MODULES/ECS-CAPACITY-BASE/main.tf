#-----------------------------------------------------------------------------
## Creates Capacity Provider linked with ASG and ECS Cluster
#-----------------------------------------------------------------------------

resource "aws_ecs_capacity_provider" "cas" {
  name = "${var.project_name}_ECS_CapacityProvider_${var.environment}"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.autoscaling_grp_arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size   = var.ECS_Capacity_Components["maximum_scaling_step_size"] #Maximum amount of EC2 instances that should be added on scale-out
      minimum_scaling_step_size   = var.ECS_Capacity_Components["minimum_scaling_step_size"] #Minimum amount of EC2 instances that should be added on scale-out
      status                      = "ENABLED"
      target_capacity             = var.ECS_Capacity_Components["target_capacity"] #Amount of resources of container instances that should be used for task placement in %
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "cas" {
  cluster_name       = var.aws_ecs_cluster_name
  capacity_providers = [aws_ecs_capacity_provider.cas.name]
}

#-----------------------------------------------------------------------------
## Define Target Tracking on ECS Cluster Task level
#-----------------------------------------------------------------------------
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.ECS_Appautoscaling_Components["max_capacity"] #How many ECS tasks should maximally run in parallel
  min_capacity       = var.ECS_Appautoscaling_Components["min_capacity"]  #How many ECS tasks should minimally run in parallel
  resource_id        = "service/${var.aws_ecs_cluster_name}/${var.aws_ecs_service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"

}

## Policy for CPU tracking
resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
  name               = "${var.project_name}_CPUTargetTrackingScaling_${var.environment}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "service/${var.aws_ecs_cluster_name}/${var.aws_ecs_service_name}"
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.ECS_Appautoscaling_Components["target_value_cpu_policy"] #Target tracking for CPU usage in %

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}

## Policy for memory tracking
resource "aws_appautoscaling_policy" "ecs_memory_policy" {
  name               = "${var.project_name}_MemoryTargetTrackingScaling_${var.environment}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.ECS_Appautoscaling_Components["target_value_memory_policy"] #Target tracking for memory usage in %

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

