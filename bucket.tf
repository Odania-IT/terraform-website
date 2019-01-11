resource "aws_s3_bucket" "web-origin" {
  bucket = "${var.domain}"
  acl = "private"
  region = "${data.aws_region.current.id}"

  cors_rule {
    allowed_headers = "${var.cors_allowed_headers}"
    allowed_methods = "${var.cors_allowed_methods}"
    allowed_origins = "${var.cors_allowed_origins}"
    expose_headers = "${var.cors_expose_headers}"
    max_age_seconds = "${var.cors_max_age_seconds}"
  }
}

resource "aws_s3_bucket" "logging" {
  count = "${var.log_enabled == "true" ? 1 : 0}"
  bucket = "${var.domain}-logging"
  acl = "log-delivery-write"
  region = "${data.aws_region.current.id}"

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id = "${var.domain}-logging-lifecycle-rule"
    enabled = true
    tags = "${var.tags}"

    expiration {
      days = "${var.log_expiration_days}"
    }
  }
}
