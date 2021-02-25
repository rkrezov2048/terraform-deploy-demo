terraform {
  backend "s3" {
    bucket         = "cognism-tfstate-90851"
    key            = "dev/vpc-demo/terraform.tfstate"
    region         = "us-east-1"    
    dynamodb_table = "cognism--dynamo-tf-backend"
  }
}

