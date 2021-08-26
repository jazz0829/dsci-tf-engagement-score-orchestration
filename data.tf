data "template_file" "sfn_definition" {
  template = "${file(var.step_function_definition_file)}"

  vars = {
    cig-sagemaker-slack-lambda-arn                        = "${data.aws_lambda_function.notify_slack.arn}"
    cig-engagement-score-get-param-lambda-arn             = "${module.lambdas.lambda_engagement_score_get_param_arn}"
    dsci-engagement-score-run-emr-job-arn                 = "${data.aws_lambda_function.run_emr.arn}"
    dsci-engagement-score-emr-get-status-lambda-arn       = "${data.aws_lambda_function.get_emr_cluster_status.arn}"
  }
}

data "aws_lambda_function" "notify_slack" {
    function_name = "cig-sagemaker-slack"
}

data "aws_lambda_function" "run_emr" {
    function_name = "cig-sagemaker-run-emr-job"
}

data "aws_lambda_function" "get_emr_cluster_status" {
  function_name = "cig-sagemaker-get-emr-cluster-status"
}

resource "aws_iam_role_policy" "iam_policy_for_state_machine" {
    name    = "${local.dsci_engagement_score_state_machine_policy_name}"
    role    = "${aws_iam_role.state_machine_role.id}"
    policy  = "${data.aws_iam_policy_document.state_machine_iam_policy_document.json}"
}


data "aws_iam_policy_document" "state_machine_iam_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction",
    ]

    resources = [
      "arn:aws:lambda:*:*:function:cig-sagemaker*",
      "arn:aws:lambda:*:*:function:dsci*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "lambda:InvokeFunction",
      "elasticmapreduce:RunJobFlow",
      "elasticmapreduce:terminateJobFlows",
      "elasticmapreduce:addJobFlowSteps",
      "elasticmapreduce:DescribeCluster",
      "elasticmapreduce:DescribeStep",
      "iam:PassRole",
      "s3:*"
    ]

    resources = [
      "*",
      "arn:aws:lambda:*:*:function:cig-start-glue-crawler",
      "arn:aws:lambda:*:*:function:cig-get-glue-crawler-status",
    ]
  }
}

data "aws_iam_policy_document" "state_machine_assume_role_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

# data "aws_sns_topic" "info_topic" {
#   name = "${var.info_topic_name}"
# }