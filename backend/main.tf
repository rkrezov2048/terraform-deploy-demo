resource "random_integer" "random" {
  min = 10000
  max = 99999
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = local.bucket_name
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }
}

resource "aws_dynamodb_table" "tf_backend" {
  name           = local.dynamo_name
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_iam_group" "bucket_full_acc" {
  name = "${local.bucket_name}-full-access"
}

resource "aws_iam_group" "bucket_read_acc" {
  name = "${local.bucket_name}-read-access"
}

resource "aws_iam_group_membership" "full_acc" {
  name  = aws_iam_group.bucket_full_acc.name
  users = var.full_access_users
  group = aws_iam_group.bucket_full_acc.name
}

resource "aws_iam_group_membership" "bucket_read_acc" {
  name  = aws_iam_group.bucket_read_acc.name
  users = var.read_only_users
  group = aws_iam_group.bucket_read_acc.name
}

resource "aws_iam_group_policy" "full_acc" {
  name   = "${local.bucket_name}-full-access"
  group  = aws_iam_group.bucket_full_acc.id
  policy = local.full_access_policy
}

resource "aws_iam_group_policy" "read_acc" {
  name   = "${local.bucket_name}-read_acc"
  group  = aws_iam_group.bucket_read_acc.id
  policy = local.read_access_policy
} 