#resource "aws_route53_record" "domain_name" {
#  zone_id = data.aws_route53_zone.this.zone_id
#  name    = var.domain_name
#  type    = "A"
#
#  alias {
#    name                   = aws_cloudfront_distribution.this.domain_name
#    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
#    evaluate_target_health = false
#  }
#}
#
#data "aws_route53_zone" "this" {
#  name         = var.domain_name
#  private_zone = false
#}
