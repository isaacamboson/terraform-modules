#!/bin/bash

## Configure cluster name using the template variable ${ecs_cluster_name}

echo ECS_CLUSTER=${ecs_cluster_name} >> /etc/ecs/ecs.config

load_balancer_dns=${LB_DNS}

#updating rds instance / database with the new load balancer dns from terraform output
rds_mysql_endpoint=${rds_mysql_ept}
rds_mysql_user=${rds_mysql_usr}
rds_mysql_password=${rds_mysql_pwd}
rds_mysql_database=${rds_mysql_db}

mysql -h $rds_mysql_endpoint -u $rds_mysql_user -p$rds_mysql_password -D $rds_mysql_database <<EOF
UPDATE wp_options SET option_value = "$load_balancer_dns" WHERE option_id = '1';
UPDATE wp_options SET option_value = "$load_balancer_dns" WHERE option_id = '2';
EOF


#-------------------------------------------------------------------------------------------------------

# sudo su - 

#EBS configuration
# partitioning disk - sdb (xvdb)
fdisk /dev/sdb <<EEOF
p
n
p
1
2048
20971519
p
w
EEOF
fdisk /dev/sdc <<EEOF
p
n
p
1
2048
20971519
p
w
EEOF
fdisk /dev/sdd <<EEOF
p
n
p
1
2048
20971519
p
w
EEOF
fdisk /dev/sde <<EEOF
p
n
p
1
2048
20971519
p
w
EEOF
fdisk /dev/sdf <<EEOF
p
n
p
1
2048
20971519
p
w
EEOF

# creating the disk labels (physical volume)
pvcreate /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1

# creating volume group 
vgcreate stack_vg /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1 /dev/sdf1

# listing volume group(s)
vgs

# creating new logical volumes (LUNs) from volume groups with 8GB of space allocated initially
lvcreate -L 8G -n Lv_u01 stack_vg
lvcreate -L 8G -n Lv_u02 stack_vg
lvcreate -L 8G -n Lv_u03 stack_vg
lvcreate -L 8G -n Lv_u04 stack_vg
lvcreate -L 8G -n Lv_backup stack_vg

# listing volumes 
lvs

# creating ext4 filesystems on the logical volumes
mkfs.ext4 /dev/stack_vg/Lv_u01
mkfs.ext4 /dev/stack_vg/Lv_u02
mkfs.ext4 /dev/stack_vg/Lv_u03
mkfs.ext4 /dev/stack_vg/Lv_u04
mkfs.ext4 /dev/stack_vg/Lv_backup

# creating mount points that will hold the space for logical volumes
mkdir /u01
mkdir /u02
mkdir /u03
mkdir /u04
mkdir /backup

# mounting the volumes on the mount points
mount /dev/stack_vg/Lv_u01 /u01
mount /dev/stack_vg/Lv_u02 /u02
mount /dev/stack_vg/Lv_u03 /u03
mount /dev/stack_vg/Lv_u04 /u04
mount /dev/stack_vg/Lv_backup /backup

# extending the logical volumes by 2GB of space 
lvextend -L +2G /dev/mapper/stack_vg-Lv_u01
lvextend -L +2G /dev/mapper/stack_vg-Lv_u02
lvextend -L +2G /dev/mapper/stack_vg-Lv_u03
lvextend -L +2G /dev/mapper/stack_vg-Lv_u04
lvextend -L +1G /dev/mapper/stack_vg-Lv_backup

# resize gets reflected after running command below
resize2fs /dev/mapper/stack_vg-Lv_u01
resize2fs /dev/mapper/stack_vg-Lv_u02
resize2fs /dev/mapper/stack_vg-Lv_u03
resize2fs /dev/mapper/stack_vg-Lv_u04
resize2fs /dev/mapper/stack_vg-Lv_backup

echo "/dev/mapper/stack_vg-Lv_u01 /u01 ext4 defaults 1 2" >> "/etc/fstab"
echo "/dev/mapper/stack_vg-Lv_u02 /u02 ext4 defaults 1 2" >> "/etc/fstab"
echo "/dev/mapper/stack_vg-Lv_u03 /u03 ext4 defaults 1 2" >> "/etc/fstab"
echo "/dev/mapper/stack_vg-Lv_u04 /u04 ext4 defaults 1 2" >> "/etc/fstab"
echo "/dev/mapper/stack_vg-Lv_backup /backup ext4 defaults 1 2" >> "/etc/fstab"

ls -ltr


