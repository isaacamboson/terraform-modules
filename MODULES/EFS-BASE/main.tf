locals {
  EFSPrefix = ""
}

#----------------------------------------------------------------
# creating the EFS (Elastic File System) for the application
#----------------------------------------------------------------
resource "aws_efs_file_system" "efs" {
  creation_token   = "${var.project_name}-EFS"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = merge({Name  = "${local.EFSPrefix != "" ? local.EFSPrefix : "${var.project_name}_file_system"}"}, var.resource_tags)

}

# creating the efs mount target in two subnets in two AZs
resource "aws_efs_mount_target" "efs_mount" {
    count           = length(var.efs_private_subnets_id)
    file_system_id  = aws_efs_file_system.efs.id
    subnet_id       = element(var.efs_private_subnets_id, count.index)
    security_groups = [var.efs_sg_id]
}

# # creating the efs mount target in us-east-1b
# resource "aws_efs_mount_target" "efs_mount_b" {
#   file_system_id  = aws_efs_file_system.efs.id
#   subnet_id       = aws_subnet.private_subnets[5].id
#   security_groups = [aws_security_group.app-server-sg.id]
# }