resource "aws_acm_certificate" "main" {
  domain_name       = var.app_domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "main" {
  name = var.app_domain_name
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  name    = each.value.name
  type    = each.value.type
  zone_id = aws_route53_zone.main.zone_id
  ttl     = "60"
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = values(aws_route53_record.validation)[*].fqdn
}

resource "aws_route53_record" "alias_record" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.api_domain_name
  type    = "A"

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = false
  }
}