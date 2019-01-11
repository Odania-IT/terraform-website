output "s3_bucket_name" {
  value = "${aws_s3_bucket.web-origin.id}"
}

output "domain" {
  value = "${var.domain}"
}

output "rest-api-id" {
  value = "${aws_api_gateway_rest_api.default.id}"
}

output "rest-api-root-resource-id" {
  value = "${aws_api_gateway_rest_api.default.root_resource_id}"
}

output "cloudfront-domain-name" {
    value = "${aws_cloudfront_distribution.default.domain_name}"
}

output "cloudfront-zone-id" {
  value = "${aws_cloudfront_distribution.default.hosted_zone_id}"
}
