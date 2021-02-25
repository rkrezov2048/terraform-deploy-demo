locals {
  dynamo_name = "${var.name_prefix}--dynamo-tf-backend"
  bucket_name = "${var.name_prefix}-tfstate-${random_integer.random.result}"
}


locals {
  full_access_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [
          "arn:aws:s3:::${local.bucket_name}",
          "arn:aws:s3:::${local.bucket_name}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": ["dynamo:*"],
      "Resource": "arn:aws:dynamodb:::${local.dynamo_name}"
    }
  ]
}
EOF
}

locals {
  read_access_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "s3:Get*",
          "s3:List*"
      ],
      "Resource": [
          "arn:aws:s3:::${local.bucket_name}",
          "arn:aws:s3:::${local.bucket_name}/*"
      ]
    }
  ]
}
EOF
}