variable "use_Swap_lb" {
  type    = bool
  default = false
}

# aws_route53_record.abc:
resource "aws_route53_record" "abc" {
    name    = "abc.com"
    type    = "A"
    zone_id = "annxnxnunxun"

    alias {
        evaluate_target_health = true
        name                   = var.use_Swap_lb ? var.prod_lb_dns_name : var.test_lb_dns_name
        zone_id                = var.use_Swap_lb ? var.prod_lb_zone_id : var.test_lb_zone_id
    }
}

# aws_route53_record.test_abc:
resource "aws_route53_record" "test_abc" {
    name    = "test.abc.com"
    type    = "A"
    zone_id = "cccdcdcdccc"

    alias {
        evaluate_target_health = true
        name                   = var.use_Swap_lb ? var.test_lb_dns_name : var.prod_lb_dns_name
        zone_id                = var.use_Swap_lb ? var.test_lb_zone_id : var.prod_lb_zone_id
    }
}

provider "aws" {
  region = "me-cwest-5"
}


For updating alternate domain name in cloufront distribution:


resource "aws_route53_record" "production_record" {
  zone_id = "your_zone_id"
  name    = "abc.com"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.var.cf_distribution[var.swap ? "test" : "production"].domain_name
    zone_id                = aws_cloudfront_distribution.var.cf_distribution[var.swap ? "test" : "production"].hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "test_record" {
  zone_id = "your_zone_id"
  name    = "test.abc.com"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.var.cf_distribution[var.swap ? "production" : "test"].domain_name
    zone_id                = aws_cloudfront_distribution.var.cf_distribution[var.swap ? "production" : "test"].hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_cloudfront_distribution" "production" {
  ...
  
  aliases = var.swap ? ["test.abc.com"] : ["abc.com"]
}

resource "aws_cloudfront_distribution" "test" {
  ...
  
  aliases = var.swap ? ["abc.com"] : ["test.abc.com"]
}

locals {
  swap = true  # Set this to true to swap, false to not swap
}
