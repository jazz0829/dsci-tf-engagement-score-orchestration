variable "name_prefix" {}

variable "handler" {
  default = "handler.lambda_handler"
}

variable "runtime" {
  default = "python3.7"
}

variable "lambda_default_timeout" {
  default = 240
}
variable "default_tags" {
  type    = "map"
  default = {}
}
variable "engagement_score_dynamodb_arn" {}
variable "engagement_score_dynamodb_name" {}
variable "environment" {}
variable "region" {}

variable "accountid" {}

variable "env_prefix" {}