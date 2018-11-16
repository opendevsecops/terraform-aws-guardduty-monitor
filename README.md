[![Codacy Badge](https://api.codacy.com/project/badge/Grade/98a1b947bb6745899ed248ae91f62b34)](https://www.codacy.com/app/OpenDevSecOps/terraform-aws-guardduty-monitor?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=opendevsecops/terraform-aws-guardduty-monitor&amp;utm_campaign=Badge_Grade)
[![Follow on Twitter](https://img.shields.io/twitter/follow/opendevsecops.svg?logo=twitter)](https://twitter.com/opendevsecops)

# AWS GuardDuty Monitor Terraform Module

A terraform module to monitor GuardDuty with Slack and Email (soon).

## Getting Started

Getting started is easy. You will need GuardDuty provisioned via terraform or manually activated via the AWS console. Once GuardDuty is activated, simply import the module and configure as desired. Here is a complete example:

```terraform
resource "aws_guardduty_detector" "default" {
  enable = true
}

module "guardduty_monitor" {
  source = "opendevsecops/guardduty-monitor/aws"

  monitor_slack_notification_url = "${var.monitor_slack_notification_url}"
}
```

The module is automatically published to the Terraform Module Registry. More information about the available inputs, outputs, dependencies and instructions how to use the module can be found at the official page [here](https://registry.terraform.io/modules/opendevsecops/guardduty-monitor).
