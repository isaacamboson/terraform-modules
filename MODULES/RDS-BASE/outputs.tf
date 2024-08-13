output "aws_db_subnet_group_id" {
  value = aws_db_subnet_group.db_subnet_group_name.id
}

output "aws_db_instance_id" {
  value = aws_db_instance.app_db_instance.id
}