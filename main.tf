module "monitor" {
  source = "./modules/monitor"

  name                   = var.monitor_name
  role_name              = var.monitor_role_name
  slack_notification_url = var.monitor_slack_notification_url
}

resource "aws_cloudwatch_event_rule" "main" {
  name = var.event_rule_name

  event_pattern = <<EOF
{
  "source": [
    "aws.guardduty"
  ],
  "detail-type": [
    "GuardDuty Finding"
  ]
}
EOF
}

resource "aws_cloudwatch_event_target" "main" {
  rule = aws_cloudwatch_event_rule.main.name
  arn  = module.monitor.arn
}

resource "aws_lambda_permission" "main" {
  action        = "lambda:InvokeFunction"
  function_name = module.monitor.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.main.arn
}
