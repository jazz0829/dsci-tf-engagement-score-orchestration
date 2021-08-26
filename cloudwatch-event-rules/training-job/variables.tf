variable "start_training_event_input_file" {
    default = "cloudwatch-event-rules/training-job/input.json"
}
variable "step_function_definition_file" {
  default = "step-function.json"
}

variable "emr_core_node_instance_type" {
    default = "r5d.4xlarge"
}

variable "emr_core_node_instance_count" {
    default = 3
}

variable "emr_master_node_instance_type" {
    default = "m5.xlarge"
}

variable "emr_master_node_instance_count" {
    default = 1
}

variable "handler" {
  default = "handler.lambda_handler"
}

variable "runtime" {
  default = "python3.7"
}

variable "high_write_capacity_units" {
  default = 200
}

variable "high_read_capacity_units" {
  default = 10
}

data "template_file" "event_input" {
  template = "${file(var.start_training_event_input_file)}"

  vars = {
    emr_log_output                         = "s3://dt-dsci-contract-prediction-428785023349-eu-west-1/emr-logs/"
  }
}

variable "emr_subnet_id" {}

variable "name_prefix" {}

variable "dsci_dynamo_table_name" {}


