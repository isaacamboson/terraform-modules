output "aws_efs_file_system_id" {
  value = aws_efs_file_system.efs.id
}

output "aws_efs_mount_target_id" {
  value = aws_efs_mount_target.efs_mount.id
}

