variable "domain" {
  description = "Domain name"
}

variable "cloudfront-enabled" {
  default = "true"
  description = "Cloudfront distribution enabled"
}

variable "is_ipv6_enabled" {
  default = "true"
  description = "State of CloudFront IPv6"
}

variable "default_root_object" {
  default = "index.html"
  description = "Object that CloudFront return when requests the root URL"
}

variable "price_class" {
  default = "PriceClass_100"
  description = "Price class for this distribution: `PriceClass_All`, `PriceClass_200`, `PriceClass_100`"
}

variable "log_enabled" {
  default = "true"
  description = "Enable logging"
}

variable "log_include_cookies" {
  default = "false"
  description = "Include cookies in access logs"
}

variable "log_prefix" {
  default = ""
  description = "Path of logs in S3 bucket"
}

variable "log_expiration_days" {
  default = 7
  description = "Log expiration in days"
}

variable "aliases" {
  type = "list"
  description = "List of FQDN's - Used to set the Alternate Domain Names (CNAMEs) setting on Cloudfront"
  default = []
}

variable "origin_path" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html#DownloadDistValuesOriginPath
  description = "An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin. It must begin with a /. Do not add a / at the end of the path."
  default = ""
}

variable "acm_certificate_arn" {
  description = "Existing ACM Certificate ARN"
  default = ""
}

variable "allowed_methods" {
  type = "list"
  default = [
    "DELETE",
    "GET",
    "HEAD",
    "OPTIONS",
    "PATCH",
    "POST",
    "PUT"]
  description = "List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for AWS CloudFront"
}

variable "cached_methods" {
  type = "list"
  default = [
    "GET",
    "HEAD"]
  description = "List of cached methods (e.g. GET, PUT, POST, DELETE, HEAD)"
}

variable "default_ttl" {
  default = "60"
  description = "Default amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "min_ttl" {
  default = "0"
  description = "Minimum amount of time that you want objects to stay in CloudFront caches"
}

variable "max_ttl" {
  default = "86400"
  description = "Maximum amount of time (in seconds) that an object is in a CloudFront cache"
}

variable "compress" {
  default = "false"
  description = "Compress content for web requests that include Accept-Encoding: gzip in the request header"
}

variable "forward_query_string" {
  default     = "false"
  description = "Forward query strings to origin"
}

variable "forward_header_values" {
  default     = "false"
  description = "Forward headers to origin"
}

variable "forward_cookies" {
  default     = "none"
  description = "Forward cookie to origin"
}

variable "viewer_protocol_policy" {
  description = "Redirect all to https"
  default     = "redirect-to-https"
}

variable "geo_restriction_type" {
  default     = "none"
  description = "Geo restriction type"
}

variable "geo_restriction_locations" {
  type = "list"

  default     = []
  description = "List of countries"
}

variable "custom_error_responses" {
  # http://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/custom-error-pages.html#custom-error-pages-procedure
  description = "Custom error responses"

  type    = "list"
  default = []
}

variable "tags" {
  type        = "map"
  default     = {}
  description = "Tags for resources"
}

# Cors
variable "cors_allowed_headers" {
  type        = "list"
  default     = ["*"]
  description = "List of allowed headers for S3 bucket"
}

variable "cors_allowed_methods" {
  type        = "list"
  default     = ["GET"]
  description = "List of allowed methods (e.g. GET, PUT, POST, DELETE, HEAD) for S3 bucket"
}

variable "cors_allowed_origins" {
  type        = "list"
  default     = ["*"]
  description = "List of allowed origins (e.g. example.com, test.com) for S3 bucket"
}

variable "cors_expose_headers" {
  type        = "list"
  default     = ["ETag"]
  description = "List of expose header in the response for S3 bucket"
}

variable "cors_max_age_seconds" {
  default     = "3600"
  description = "Time in seconds that browser can cache the response for S3 bucket"
}

variable "zone_id" {
  default = ""
  description = "Route53 Zone to add record"
}
