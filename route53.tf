resource "aws_route53_record" "cloudfront-target" {
  count = "${var.zone_id == "" ? 0 : 1}"

  name = "${var.domain}"
  type = "A"
  zone_id = "${var.zone_id}"

  alias {
    evaluate_target_health = false
    name = "${aws_cloudfront_distribution.default.domain_name}"
    zone_id = "${aws_cloudfront_distribution.default.hosted_zone_id}"
  }
}
