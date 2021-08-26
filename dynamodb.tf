
resource "aws_dynamodb_table" "dynamodb_engagement_score_model_table" {
  name           = "${local.dsci_dynamo_table_name}"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "Mode"
  range_key      = "Category"

  attribute {
    name = "Mode"
    type = "S"
  }

  attribute {
    name = "Category"
    type = "S"
  }

  tags = "${var.default_tags}"
}