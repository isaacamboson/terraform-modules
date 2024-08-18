# route53 for application
resource "aws_route53_record" "route53" {
    zone_id = var.zone_id
    name    = var.route53_name
    type    = var.route53_type
    # ttl     = 5

    alias {
        name                   = var.alb_lb_dns_name
        zone_id                = var.alb_lb_zone_id
        evaluate_target_health = true
    }
}