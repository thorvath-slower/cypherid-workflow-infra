# CZID-447 — toggle for the log-based CloudWatch -> Slack alerting module
# (cloudwatch-alerting.tf).
#
# Declared here (a committed file) rather than in the env-injected, gitignored
# terraform/variables.tf, so it travels with the code. Has a default ("auto"), so
# no wrapper/env change is required to plan.

variable "enable_cloudwatch_alerting" {
  description = <<-EOT
    Whether to enable the log-based CloudWatch -> Slack alerting module.
      "auto" (default): enable only where there is a non-empty subscription-filter
        map (prod + staging) AND SLACK_OAUTH_TOKEN_SECRET_NAME is set. dev/sandbox/
        test stay off.
      "on":  force enabled (requires a Slack token secret to be configured).
      "off": force disabled.
  EOT
  type        = string
  default     = "auto"

  validation {
    condition     = contains(["auto", "on", "off"], var.enable_cloudwatch_alerting)
    error_message = "enable_cloudwatch_alerting must be one of: auto, on, off."
  }
}
