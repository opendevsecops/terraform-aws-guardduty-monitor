variable "name" {
  description = "A unique name for your Lambda Function"
  default     = "opendevsecops_guardduty_monitor"
}

variable "role_name" {
  description = "A unique name for your Lambda Function Role"
  default     = "opendevsecops_guardduty_monitor_role"
}

variable "slack_notification_url" {
  description = "URL for slack notifications"
  default     = ""
}
