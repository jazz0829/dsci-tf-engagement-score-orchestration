
resource "aws_sfn_state_machine" "sfn_state_machine" {
    name        = "${local.dsci_training_step_function_name}"
    role_arn    = "${aws_iam_role.state_machine_role.arn}"
    definition  = "${data.template_file.sfn_definition.rendered}"

    tags = "${var.default_tags}"
}