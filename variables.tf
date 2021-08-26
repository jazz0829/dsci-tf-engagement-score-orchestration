variable "region" {
    default = "eu-west-1"
}

variable "default_tags" {
    description = "Map of tags to add to all resources"
    type = "map"

    default = {
        Terraform   = "true"
        GitHub-Repo = "exactsoftware/dsci-tf-engagement-score"
        Project     = "Contract-Prediction"
    }
}

variable "step_function_name" {
  default = "engagement-score-step-function"
}

variable "step_function_definition_file" {
  default = "step-function.json"
}

variable "info_topic_name" {
  default = "cig-notifications-info"
}

variable "default_period" {
  default = "60"
}


variable "visibility_timeout_seconds" {
  default = 900
}


variable "environment" {}
variable "job_event_rule_enabled" {}
variable "emr_subnet_id" {}

variable "accountid" {}

variable "env_prefix" {}