#Creating ECS - Elastic Container Service for the application (using EC2 launch type)

#creating the ECS cluster 
resource "aws_ecs_cluster" "ecs_cluster" {
  name          = "${var.project_name}-app-cluster"

  tags = {
    Name        = "${var.project_name}-app-cluster"
  }
}

#creating the ECS task definition
resource "aws_ecs_task_definition" "ecs-def" {
  family                       = "${var.project_name}-app-task-def"
  execution_role_arn           = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn                = aws_iam_role.ecs_task_iam_role.arn
  requires_compatibilities     = ["EC2"]
  container_definitions        = var.container_definitions

  runtime_platform {
    cpu_architecture           = "X86_64"
    operating_system_family    = "LINUX"
  }

  tags = {
    Name = "${var.project_name}-app-container"
  }
}

#creating the ECS service
resource "aws_ecs_service" "ecs-service" {
  name                               = "${var.project_name}-app-service"
  iam_role                           = aws_iam_role.ecs_service_role.arn
  cluster                            = aws_ecs_cluster.ecs-cluster.id
  task_definition                    = aws_ecs_task_definition.ecs-def.arn
  desired_count                      = var.desired_count   #How many ECS tasks should run in parallel  #How many percent of a service must be running to still execute a safe deployment
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent  #How many percent of a service must be running to still execute a safe deployment
  deployment_maximum_percent         = var.deployment_maximum_percent #How many additional tasks are allowed to run (in percent) while a deployment is executed

  load_balancer {
    target_group_arn                 = var.aws_lb_target_group_arn
    #Name of the container to associate with the load balancer (as it appears in a container definition)
    container_name                   = "${var.project_name}-app-container"
    container_port                   = var.app_port
  }

  # Spread tasks evenly accross all Availability Zones for High Availability
  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  # Make use of all available space on the Container Instances
  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

}

#-----------------------------------------------------------------------------
## Creates Capacity Provider linked with ASG and ECS Cluster
#-----------------------------------------------------------------------------

resource "aws_ecs_capacity_provider" "cas" {
  name = "${var.project_name}_ECS_CapacityProvider_${var.environment}"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = var.autoscaling_grp_arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size   = var.maximum_scaling_step_size #Maximum amount of EC2 instances that should be added on scale-out
      minimum_scaling_step_size   = var.minimum_scaling_step_size #Minimum amount of EC2 instances that should be added on scale-out
      status                      = "ENABLED"
      target_capacity             = var.target_capacity #Amount of resources of container instances that should be used for task placement in %
    }
  }
}

resource "aws_ecs_cluster_capacity_providers" "cas" {
  cluster_name       = aws_ecs_cluster.ecs-cluster.name
  capacity_providers = [aws_ecs_capacity_provider.cas.name]
}

#-----------------------------------------------------------------------------
## Define Target Tracking on ECS Cluster Task level
#-----------------------------------------------------------------------------
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = var.max_capacity #How many ECS tasks should maximally run in parallel
  min_capacity       = var.min_capacity  #How many ECS tasks should minimally run in parallel
  resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.ecs-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

## Policy for CPU tracking
resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
  name               = "${var.project_name}_CPUTargetTrackingScaling_${var.environment}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = "service/${aws_ecs_cluster.ecs-cluster.name}/${aws_ecs_service.ecs-service.name}"
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = var.target_value_cpu_policy #Target tracking for CPU usage in %

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
    target_value = var.target_value_memory_policy #Target tracking for memory usage in %

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }
  }
}

