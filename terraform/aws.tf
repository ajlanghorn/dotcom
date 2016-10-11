provider "aws" {}

resource "aws_s3_bucket" "dotcom" {
  bucket = "ajlanghorn.com"
  acl = "public-read"
  policy = "${file("dotcom.json")}"
  versioning {
    enabled = true
  }
  website {
    index_document = "index.html"
  }
}

resource "aws_cloudfront_distribution" "dotcom" {
  comment = "ajlanghorn.com"
  default_root_object = "index.html"
  enabled = true

  default_cache_behavior {
    allowed_methods = ["HEAD","GET"]
    cached_methods = ["HEAD","GET"]
    default_ttl = "0"
    forwarded_values {
      cookies {
        forward = "none"
      }
      query_string = "false"
    }
    min_ttl = "0"
    max_ttl = "0"
    target_origin_id = "ajlanghorn.com"
    viewer_protocol_policy = "allow-all"
  }

  origin {
    domain_name = "ajlanghorn.com.s3-website-eu-west-1.amazonaws.com"
    origin_id = "ajlanghorn.com"

    custom_origin_config {
      http_port = "80"
      https_port = "443"
      origin_protocol_policy = "match-viewer"
      origin_ssl_protocols = ["TLSv1.2"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "arn:aws:acm:us-east-1:189274725011:certificate/273099b8-e7c6-4a82-8091-41b343a9f2f0"
    minimum_protocol_version = "TLSv1"
    ssl_support_method = "sni-only"
  }

}
