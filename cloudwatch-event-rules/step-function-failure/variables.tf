variable "failure_description" {
  default = "Cloudwatch event rule to detect failure of Engagement score step function"
}

variable "step_function_name" {}
variable "step_function_arn" {}
variable "notification_topic_arn" {}

variable "tags" {
  type = "map"
}
