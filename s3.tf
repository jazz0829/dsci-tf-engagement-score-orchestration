resource "aws_s3_bucket" "dsci_engagement_score_model_bucket" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  acl    = "private"

  tags = "${var.default_tags}"
}

# resource "aws_s3_bucket_object" "engagement_score_dependencies" {
#   bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
#   key    = "scripts/EMR/install_dependencies.sh"
#   source = "${path.module}/scripts/install_dependencies.sh"
#   etag   = "${md5(file("${path.module}/scripts/install_dependencies.sh"))}"

#   tags = "${var.default_tags}"
# }

# resource "aws_s3_bucket_object" "process_emr_engagement_score_requests" {
#   bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
#   key    = "scripts/EMR/main.py"
#   source = "${path.module}/scripts/main.py"
#   etag   = "${md5(file("${path.module}/scripts/main.py"))}"

#   tags = "${var.default_tags}"
# }

resource "aws_s3_bucket_object" "engagement_score_dependencies" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/install_dependencies.sh"
  source = "${path.module}/pyspark/install_dependencies.sh"
  etag   = "${md5(file("${path.module}/pyspark/install_dependencies.sh"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "process_emr_engagement_score_requests" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/main.py"
  source = "${path.module}/pyspark/main.py"
  etag   = "${md5(file("${path.module}/pyspark/main.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_accountancy_feature" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/accountancy_feature.py"
  source = "${path.module}/pyspark/common/accountancy_feature.py"
  etag   = "${md5(file("${path.module}/pyspark/common/accountancy_feature.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_accounting_established" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/accounting_established.py"
  source = "${path.module}/pyspark/common/accounting_established.py"
  etag   = "${md5(file("${path.module}/pyspark/common/accounting_established.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_accounting_onboarding" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/accounting_onboarding.py"
  source = "${path.module}/pyspark/common/accounting_onboarding.py"
  etag   = "${md5(file("${path.module}/pyspark/common/accounting_onboarding.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_common_feature" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/common_feature.py"
  source = "${path.module}/pyspark/common/common_feature.py"
  etag   = "${md5(file("${path.module}/pyspark/common/common_feature.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_config" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/config.py"
  source = "${path.module}/pyspark/common/config.py"
  etag   = "${md5(file("${path.module}/pyspark/common/config.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_logistic_regression" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/logistic_regression.py"
  source = "${path.module}/pyspark/common/logistic_regression.py"
  etag   = "${md5(file("${path.module}/pyspark/common/logistic_regression.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_manufacturing_feature" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/manufacturing_feature.py"
  source = "${path.module}/pyspark/common/manufacturing_feature.py"
  etag   = "${md5(file("${path.module}/pyspark/common/manufacturing_feature.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_model_operation" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/model_operation.py"
  source = "${path.module}/pyspark/common/model_operation.py"
  etag   = "${md5(file("${path.module}/pyspark/common/model_operation.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_other_feature" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/other_feature.py"
  source = "${path.module}/pyspark/common/other_feature.py"
  etag   = "${md5(file("${path.module}/pyspark/common/other_feature.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_professional_services_features" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/professional_services_features.py"
  source = "${path.module}/pyspark/common/professional_services_features.py"
  etag   = "${md5(file("${path.module}/pyspark/common/professional_services_features.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_stratified_cross_validator" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/stratified_cross_validator.py"
  source = "${path.module}/pyspark/common/stratified_cross_validator.py"
  etag   = "${md5(file("${path.module}/pyspark/common/stratified_cross_validator.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_utils" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/utils.py"
  source = "${path.module}/pyspark/common/utils.py"
  etag   = "${md5(file("${path.module}/pyspark/common/utils.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_wholesale_distribution_feature" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common/wholesale_distribution_feature.py"
  source = "${path.module}/pyspark/common/wholesale_distribution_feature.py"
  etag   = "${md5(file("${path.module}/pyspark/common/wholesale_distribution_feature.py"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_common_zip" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/common.zip"
  source = "${path.module}/pyspark/common.zip"
  etag   = "${md5(file("${path.module}/pyspark/common.zip"))}"

  tags = "${var.default_tags}"
}

resource "aws_s3_bucket_object" "contract_prediction_contractprediction" {
  bucket = "${var.env_prefix}-dsci-contract-prediction-${var.accountid}-eu-west-1"
  key    = "scripts/EMR/contractprediction.py"
  source = "${path.module}/pyspark/contractprediction.py"
  etag   = "${md5(file("${path.module}/pyspark/contractprediction.py"))}"

  tags = "${var.default_tags}"
}