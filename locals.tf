locals {
    name_prefix                                         = "dsci-cs"
    dsci_training_step_function_name                    = "${local.name_prefix}-${var.step_function_name}"
    dsci_engagement_score_state_machine_role_name       = "${local.dsci_training_step_function_name}-iam-role"
    dsci_engagement_score_state_machine_policy_name     = "${local.dsci_engagement_score_state_machine_role_name}-invoke-policy"
    dsci_start_training_job_event_rule_name             = "${local.name_prefix}-cw-rule-training-job"
    dsci_dynamo_table_name                              = "${local.name_prefix}-bookmark-table"
    dsci_model_bucket_name                              = "${local.name_prefix}-model"
}