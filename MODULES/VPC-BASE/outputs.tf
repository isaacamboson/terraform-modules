output "vpc_main_id" {
  value = aws_vpc.vpc_main.id
}

output "public_subnets_id" {
  value = aws_subnet.pub_subnets.*.id
}

output "private_subnets_id" {
  value = aws_subnet.pub_subnets.*.id
}

output "asg_private_subnets_id" {
  value = [aws_subnet.private_subnets[0].id, aws_subnet.private_subnets[1].id]
}

output "rds_private_subnets_id" {
  value = [aws_subnet.private_subnets[2].id, aws_subnet.private_subnets[3].id]
}

output "internet_gateway_id" {
  value = aws_internet_gateway.igw.id
}

output "public_custom_route_table_id" {
  value = aws_route.pub_custom_route_table.id
}

output "eip_nat_gateway_id" {
  value = aws_eip.eip_aws_nat_gtwy.*.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gateway_pub.*.id
}

output "private_route_table_id" {
  value = aws_route_table.private_custom_route_table.*.id
}

output "route_table_assoc_id" {
  value = aws_route_table_association.rt_association_private_subnets.*.id 
}
