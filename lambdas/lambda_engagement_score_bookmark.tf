module "lambda_engagement_score_bookmark" {
  source                      = "git@github.com:exactsoftware/dsci-tf-modules.git//src/modules/lambda_localfile?ref=v0.0.20"
  app_name                    = "${local.bookmark_lambda_function_name}"
  description                 = "Bookmark training and prediction latest execution date for engagement score"
  iam_policy_document         = "${data.aws_iam_policy_document.engagement_score_bookmark_iam_policy_document.json}"
  assume_role_policy_document = "${data.aws_iam_policy_document.lambda_assume_role.json}"
  lambda_filename             = "${data.archive_file.engagement_score_bookmark_archive_file.0.output_path}"
  lambda_source_code_hash     = "${data.archive_file.engagement_score_bookmark_archive_file.0.output_base64sha256}"
  handler                     = "${var.handler}"
  runtime                     = "${var.runtime}"

  environment_variables = {
    dynamodb_table = "${var.engagement_score_dynamodb_name}"
  }

  alarm_action_arn               = ""
  monitoring_enabled             = 0
  iteratorage_monitoring_enabled = false
  timeout                        = "${var.lambda_default_timeout}"
  tags                           = "${var.default_tags}"
}

data "null_data_source" "engagement_score_bookmark_archive_file" {
  inputs {
    filename = "${substr("${path.module}/functions/dsci-engagement-score-bookmark/handler.py", length(path.cwd) + 1, -1)}"
  }
}

data "null_data_source" "engagement_score_bookmark_archive" {
  inputs {
    filename = "${substr("${path.module}/functions/dsci-engagement-score-bookmark/dsci-engagement-score-bookmark.zip", length(path.cwd) + 1, -1)}"
  }
}

data "archive_file" "engagement_score_bookmark_archive_file" {
  type        = "zip"
  source_file = "${data.null_data_source.engagement_score_bookmark_archive_file.outputs.filename}"
  output_path = "${data.null_data_source.engagement_score_bookmark_archive.outputs.filename}"
}