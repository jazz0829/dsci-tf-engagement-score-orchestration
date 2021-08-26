module "lambdas" {
  source                             = "./lambdas"
  default_tags                       = "${var.default_tags}"
  name_prefix                        = "${local.name_prefix}"
  engagement_score_dynamodb_name     = "${local.dsci_dynamo_table_name}"
  engagement_score_dynamodb_arn      = "${aws_dynamodb_table.dynamodb_engagement_score_model_table.arn}"
  environment                        = "${var.environment}"
  region                             = "${var.region}"
  accountid                          = "${var.accountid}"
  env_prefix                         = "${var.env_prefix}"
}