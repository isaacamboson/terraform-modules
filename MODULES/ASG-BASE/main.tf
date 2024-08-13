locals {
  ServerPrefix = ""
  ASG_Name  = "${var.project_name}-ASG"
}

#-----------------------------------------------------------------------------
## Creates an ASG linked with our main VPC
#-----------------------------------------------------------------------------

resource "aws_autoscaling_group" "autoscaling_group" {
  name                      = "${var.project_name}_ASG"
  desired_capacity          = var.ASG_Components["desired_capacity"]
  max_size                  = var.ASG_Components["max_size"]
  min_size                  = var.ASG_Components["min_size"]
  health_check_grace_period = 300
  # vpc_zone_identifier       = flatten(["{var.private_subnet}", "${var.private_subnet_1b}"])
  vpc_zone_identifier       = [var.asg_private_subnets]
  health_check_type         = "EC2"
  target_group_arns         = var.aws_lb_target_group_id
  default_cooldown          = 300
  protect_from_scale_in     = true

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

  launch_template {
    id      = aws_launch_template.app-launch-temp.id
    version = "$Latest"
  }

  instance_refresh {
    strategy = "Rolling"
  }

  # lifecycle {
  #   create_before_destroy = true
  # }

  tag {
    key                 = "Name"
    value               = "${var.project_name}_ASG"
    propagate_at_launch = true
  }

  depends_on = [aws_lb.lb]
}

#-----------------------------------------------------------------------------
#creating Launch Template for the autoscaling group instances
#-----------------------------------------------------------------------------

resource "aws_launch_template" "app-launch-temp" {
  count                  = var.stack_controls["ec2_create"] == "Y" ? var.server_count : 0
  name                   = "${var.project_name}-launch-temp"
  image_id               = var.image_id
  instance_type          = var.EC2_Components["instance_type"]
  key_name               = "private-key-kp"
  user_data              = base64encode(var.user_data_filepath)
  vpc_security_group_ids = [aws_security_group.ecs_sg.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_instance_role_profile.arn
  }

  monitoring {
    enabled = true
  }

  dynamic "block_device_mappings" {
    for_each = var.device_names
    content {
      device_name = block_device_mappings.value

      ebs {
        volume_size = 10
        volume_type = "gp2"
        encrypted   = true
      }
    }
  }

  tags = {
    Name = merge({Name  = "${local.ServerPrefix != "" ? local.ServerPrefix : "App_Server_"}${count.index}"}, var.resource_tags)
  }
}


