resource "aws_iam_role" "state_machine_role" {
    name                = "${local.dsci_engagement_score_state_machine_role_name}"
    assume_role_policy  = "${data.aws_iam_policy_document.state_machine_assume_role_policy_document.json}"
    tags                = "${var.default_tags}"
}