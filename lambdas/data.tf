data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "engagement_score_get_param_iam_policy_document" {
  statement {
    effect = "Allow",

    actions = [
        "s3:ListBucket"
    ],

    resources = [
        "arn:aws:s3:::cig-${var.environment}-domain-bucket",
        "arn:aws:s3:::${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
    ]
  }
    statement {
    effect = "Allow",

    actions = [
        "s3:GetObject"
    ],

    resources = [
        "arn:aws:s3:::cig-${var.environment}-domain-bucket/Data/ActivityDaily/*",
        "arn:aws:s3:::${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1/artifacts/*"  
    ]
  }

  statement {
      effect = "Allow",

      actions = [
        "dynamodb:BatchGetItem",
        "dynamodb:BatchWriteItem",
        "dynamodb:PutItem",
        "dynamodb:GetItem",
        "dynamodb:Scan",
        "dynamodb:Query",
        "dynamodb:UpdateItem"
      ],

      resources = [
        "${var.engagement_score_dynamodb_arn}"
      ]
  }
}


data "aws_iam_policy_document" "engagement_score_bookmark_iam_policy_document" {
  statement {
      effect = "Allow",

      actions = [
        "dynamodb:PutItem"
      ],

      resources = [
        "${var.engagement_score_dynamodb_arn}"
      ]
  }
}
