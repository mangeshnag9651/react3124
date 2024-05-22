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

