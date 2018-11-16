module "lambda" {
  source  = "opendevsecops/lambda/aws"
  version = "0.3.0"

  source_dir  = "${path.module}/src"
  output_path = "${path.module}/build/lambda.zip"

  name      = "${var.name}"
  role_name = "${var.role_name}"

  timeout               = 900
  log_retention_in_days = 90

  environment {
    SLACK_NOTIFICATION_URL = "${var.slack_notification_url}"
  }
}
