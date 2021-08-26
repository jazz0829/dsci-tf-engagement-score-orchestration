module "lambda_engagement_score_get_param" {
  source                      = "git@github.com:exactsoftware/dsci-tf-modules.git//src/modules/lambda_localfile?ref=v0.0.20"
  app_name                    = "${local.get_param_lambda_function_name}"
  description                 = "Get execution status of models"
  iam_policy_document         = "${data.aws_iam_policy_document.engagement_score_get_param_iam_policy_document.json}"
  assume_role_policy_document = "${data.aws_iam_policy_document.lambda_assume_role.json}"
  lambda_filename             = "${data.archive_file.engagement_score_get_param_archive_file.0.output_path}"
  lambda_source_code_hash     = "${data.archive_file.engagement_score_get_param_archive_file.0.output_base64sha256}"
  handler                     = "${var.handler}"
  runtime                     = "${var.runtime}"

  environment_variables = {
    FOO = "bar"
  }

  alarm_action_arn               = ""
  monitoring_enabled             = 0
  iteratorage_monitoring_enabled = false
  timeout                        = "${var.lambda_default_timeout}"
  tags                           = "${var.default_tags}"
}



data "null_data_source" "engagement_score_get_param_lambda_file" {
  inputs {
    filename = "${substr("${path.module}/functions/dsci-engagement-score-get-param/handler.py", length(path.cwd) + 1, -1)}"
  }
}

data "null_data_source" "engagement_score_get_param_archive" {
  inputs {
    filename = "${substr("${path.module}/functions/dsci-engagement-score-get-param/dsci-engagement-score-get-param.zip", length(path.cwd) + 1, -1)}"
  }
}

data "archive_file" "engagement_score_get_param_archive_file" {
  type        = "zip"
  source_file = "${data.null_data_source.engagement_score_get_param_lambda_file.outputs.filename}"
  output_path = "${data.null_data_source.engagement_score_get_param_archive.outputs.filename}"
}