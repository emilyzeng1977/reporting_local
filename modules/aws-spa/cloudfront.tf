#resource "aws_cloudfront_distribution" "this" {
#  enabled             = true
#  default_root_object = "index.html"
#  price_class         = var.cloudfront_price_class
#
#  origin {
#    domain_name = aws_s3_bucket.this.bucket_regional_domain_name
#    origin_id   = var.domain_name
#
#    s3_origin_config {
#      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
#    }
#  }
#
#  custom_error_response {
#    error_code         = 403
#    response_code      = 200
#    response_page_path = "/index.html"
#  }
#
#  custom_error_response {
#    error_code         = 404
#    response_code      = 200
#    response_page_path = "/index.html"
#  }
#
#  default_cache_behavior {
#    allowed_methods        = ["GET", "HEAD"]
#    cached_methods         = ["GET", "HEAD"]
#    target_origin_id       = var.domain_name
#    viewer_protocol_policy = "redirect-to-https"
#
#    forwarded_values {
#      query_string = false
#
#      cookies {
#        forward = "none"
#      }
#    }
#
#    min_ttl     = var.cloudfront_min_ttl
#    default_ttl = var.cloudfront_default_ttl
#    max_ttl     = var.cloudfront_max_ttl
#
#    response_headers_policy_id = aws_cloudfront_response_headers_policy.this.id
#  }
#
#  restrictions {
#    geo_restriction {
#      restriction_type = "none"
#    }
#  }
#
#  aliases = [var.domain_name]
#
#  viewer_certificate {
#    acm_certificate_arn      = var.certificate_arn
#    minimum_protocol_version = "TLSv1"
#    ssl_support_method       = "sni-only"
#  }
#}
#
#resource "aws_cloudfront_response_headers_policy" "this" {
#  name = "origin-security-headers-policy"
#
#  security_headers_config {
#    content_type_options {
#      override = true
#    }
#    frame_options {
#      frame_option = "DENY"
#      override     = true
#    }
#    referrer_policy {
#      referrer_policy = "strict-origin-when-cross-origin"
#      override        = true
#    }
#    xss_protection {
#      mode_block = true
#      protection = true
#      override   = true
#    }
#    strict_transport_security {
#      access_control_max_age_sec = "31536000"
#      include_subdomains         = true
#      override                   = true
#    }
#    content_security_policy {
#      content_security_policy = "default-src 'self' data: ; frame-src *.${var.domain_name}; connect-src 'self' *.${var.domain_name}; style-src 'self' 'unsafe-inline'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; img-src 'self' data: *.gravatar.com *.wp.com ; upgrade-insecure-requests; block-all-mixed-content"
#      override                = true
#    }
#  }
#}
#
#resource "aws_cloudfront_origin_access_identity" "this" {
#}
