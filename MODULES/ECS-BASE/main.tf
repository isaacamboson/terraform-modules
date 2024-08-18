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
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs-def.arn
  desired_count                      = var.ECS_Service_Components["desired_count"]   #How many ECS tasks should run in parallel  #How many percent of a service must be running to still execute a safe deployment
  deployment_minimum_healthy_percent = var.ECS_Service_Components["deployment_minimum_healthy_percent"]  #How many percent of a service must be running to still execute a safe deployment
  deployment_maximum_percent         = var.ECS_Service_Components["deployment_maximum_percent"] #How many additional tasks are allowed to run (in percent) while a deployment is executed

  load_balancer {
    target_group_arn                 = var.aws_lb_target_group_arn
    #Name of the container to associate with the load balancer (as it appears in a container definition)
    container_name                   = "${var.project_name}-app-container"
    container_port                   = var.ECS_Service_Components["port"]
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

