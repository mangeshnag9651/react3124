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


# For updating alternate domain name in cloufront distribution:


# For updating alternate domain name in cloufront distribution:

variable "swap" {
  type    = bool
  default = true
}

variable "prod_rec_name" {
  description = "Production record name"
  default     = "abc.com"
}

variable "test_rec_name" {
  description = "Testing record name"
  default     = "test.abc.com"
}

resource "aws_cloudfront_distribution" "production" {
  ...
  aliases = var.swap ? [var.test_rec_name] : [var.prod_rec_name]
  ...
}

resource "aws_cloudfront_distribution" "test" {
  ...
  aliases = var.swap ? [var.prod_rec_name] : [var.test_rec_name]
  ...
}


# For updating cloudfront distribution with Records:

variable "swap_distribution" {
  type = bool
  default=true
}

variable "prod_dist_name" {
  description = "Production Distribution name"
  default     = "bxywxybwxbwx.cloudfront.net"
}

variable "test_dist_name" {
  description = "Test Distribution name"
  default     = "vbcbbccbcbwxbwx.cloudfront.net"
}
resource "aws_route53_record" "abc_com_record" {
  zone_id = "your_zone_id"
  name    = "abc.com"
  type    = "A"
  alias {
    name                   = var.swap_distribution ? var.test_dist_name : var.prod_dist_name
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "test_abc_com_record" {
  zone_id = "your_zone_id"
  name    = "test.abc.com"
  type    = "A"
  alias {
    name                   = var.swap_distribution ? var.prod_dist_name : var.test_dist_name
    evaluate_target_health = true
  }
}
