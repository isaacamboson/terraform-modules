# output "subnet_ids" {
#   #  value = [for s in data.aws_subnet.stack_subnets : s.cidr_block]
#   value = [for s in data.aws_subnet.stack_sub : s.id]
#   # value = [for s in data.aws_subnet.stack_sub : s.availability_zone]
#   #value = [for s in data.aws_subnet.stack_sub : element(split("-", s.availability_zone), 2)]
# }

output "LB_DNS" {
  value = module.ALB-BASE.alb_lb_dns_name
}