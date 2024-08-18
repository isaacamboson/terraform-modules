# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/${var.project_name}-ecs-log-group"
  retention_in_days = 30

  tags = {
    Name = "${var.project_name}-cw-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "${var.project_name}-ecs-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}