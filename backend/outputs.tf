output "s3_bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}

# output "dynamo_table_tf" {
#   value = aws_dynamodb_table.tf_backend.name
# }