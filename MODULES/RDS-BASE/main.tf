#creating the database for our 3-tier application

# creating subnet group name for database creation
resource "aws_db_subnet_group" "db_subnet_group_name" {
  name       = "${var.project_name}_db_subnet_group_${var.environment}"
  subnet_ids = [var.db_private_subnets]
}

# intitiating database instance for application
resource "aws_db_instance" "app_db_instance" {
  count                     = var.stack_controls["rds_create_clixx"] == "Y" ? 1 : 0
  instance_class            = var.DB_Components["instance_class"]
  allocated_storage         = var.DB_Components["allocated_storage"]
  iops                      = var.DB_Components["iops"]
  engine                    = var.DB_Components["engine"]
  engine_version            = var.DB_Components["engine_version"]
  identifier                = var.identifier
  snapshot_identifier       = var.snapshot_identifier
  vpc_security_group_ids    = [var.rds_security_group_ids]
  parameter_group_name      = var.DB_Components["parameter_group_name"]
  db_subnet_group_name      = aws_db_subnet_group.db_subnet_group_name.name
  skip_final_snapshot       = var.DB_Components["skip_final_snapshot"]
  publicly_accessible       = var.DB_Components["publicly_accessible"]

  lifecycle {
    ignore_changes = [
      iops,
      engine_version
    ]
  }
}



