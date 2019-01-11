resource "aws_cloudfront_origin_access_identity" "default" {
  comment = "cloudfront-distribution-${var.domain}"
}

locals {
  s3_origin_id = "s3-origin${var.domain}"
}

resource "aws_cloudfront_distribution" "default" {
  enabled = "${var.cloudfront-enabled}"
  is_ipv6_enabled = "${var.is_ipv6_enabled}"
  default_root_object = "${var.default_root_object}"
  price_class = "${var.price_class}"
  depends_on = [
    "aws_s3_bucket.web-origin"
  ]

  logging_config = {
    include_cookies = "${var.log_include_cookies}"
    bucket = "${aws_s3_bucket.logging.bucket_domain_name}"
    prefix = "${var.log_prefix}"
  }

  aliases = "${concat(var.aliases, list(var.domain))}"

  origin {
    domain_name = "${aws_s3_bucket.web-origin.bucket_domain_name}"
    origin_id = "${local.s3_origin_id}"
    origin_path = "${var.origin_path}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.default.cloudfront_access_identity_path}"
    }
  }

  origin {
    domain_name = "${aws_api_gateway_rest_api.default.id}.execute-api.${data.aws_region.current.id}.amazonaws.com"
    origin_id = "apiGatewayOrigin"
    origin_path = ""

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${var.acm_certificate_arn}"
    ssl_support_method = "sni-only"
    cloudfront_default_certificate = "${var.acm_certificate_arn == "" ? true : false}"
  }

  default_cache_behavior {
    allowed_methods = "${var.allowed_methods}"
    cached_methods = "${var.cached_methods}"
    target_origin_id = "${local.s3_origin_id}"
    compress = "${var.compress}"

    forwarded_values {
      query_string = "${var.forward_query_string}"
      headers = [
        "${var.forward_header_values}"
      ]
      cookies {
        forward = "${var.forward_cookies}"
      }
    }

    viewer_protocol_policy = "${var.viewer_protocol_policy}"
    default_ttl = "${var.default_ttl}"
    min_ttl = "${var.min_ttl}"
    max_ttl = "${var.max_ttl}"
  }

  ordered_cache_behavior {
    allowed_methods = "${var.allowed_methods}"
    cached_methods = ["HEAD", "GET", "OPTIONS"]
    target_origin_id = "apiGatewayOrigin"
    compress = "${var.compress}"

    "forwarded_values" {
      query_string = true
      headers = [
        "Accept",
        "Referer",
        "Authorization",
        "Content-Type"
      ]
      cookies {
        forward = "all"
      }
    }

    path_pattern = "/api/*"
    viewer_protocol_policy = "${var.viewer_protocol_policy}"
    default_ttl = "${var.default_ttl}"
    min_ttl = "${var.min_ttl}"
    max_ttl = "${var.max_ttl}"
  }

  restrictions {
    geo_restriction {
      restriction_type = "${var.geo_restriction_type}"
      locations = "${var.geo_restriction_locations}"
    }
  }

  custom_error_response = [
    "${var.custom_error_responses}"
  ]

  tags = "${var.tags}"
}
