variable "start_training_event_input_file" {
    default = "cloudwatch-event-rules/engagement-score/input.json"
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

variable "emr_subnet_id" {}