# module "dsci-engagement-score-cloudwatch-event-rule" {
#     source = "./cloudwatch-event-rules/training-job"
#     emr_subnet_id = "${var.emr_subnet_id}"
# }

# module "step-function-training-failure-event-rule" {
#   source                 = "./cloudwatch-event-rules/step-function-failure"
#   step_function_name     = "${local.dsci_training_step_function_name}"
#   step_function_arn      = "${aws_sfn_state_machine.sfn_state_machine.id}"
#   notification_topic_arn = "${data.aws_sns_topic.info_topic.arn}"

#   tags = "${var.default_tags}"
# }
