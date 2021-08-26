data "template_file" "event_input" {
    template = "${file(var.start_training_event_input_file)}"

    vars = {
        emr_core_node_instance_count        = "${var.emr_core_node_instance_count}"
        emr_core_node_instance_type         = "${var.emr_core_node_instance_type}"
        emr_master_node_instance_count      = "${var.emr_master_node_instance_count}"
        emr_master_node_instance_type       = "${var.emr_master_node_instance_type}"
        emr_subnet_id                       = "${var.emr_subnet_id}"
    }
}