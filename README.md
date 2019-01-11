# Terraform Module to create a website

## Usage

	module "website" {
		source = "./website"
		
		domain = "www.example.com"
		log_prefix = "www.example.com"
		acm_certificate_arn = "${aws_acm_certificate.example.arn}"
		zone_id = "${aws_route53_zone.example.zone_id}"
		
		tags = {
			Service = "example-service",
			Environment = "infrastructure"
		}
	}
