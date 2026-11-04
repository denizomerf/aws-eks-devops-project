resource "aws_wafv2_web_acl" "main" {
  provider = aws.us_east_1
  name     = "InsightPoll-WAF-ACL"
  scope    = "CLOUDFRONT"

  default_action {
    allow {}
  }


  rule {
    name     = "AWS-Managed-Core-Rule-Set"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "aws-managed-rules-common"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "InsightPoll-WAF"
    sampled_requests_enabled   = true
  }
}