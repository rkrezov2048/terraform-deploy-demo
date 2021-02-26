data "terraform_remote_state" "vpc_dev" {
  backend = "s3"
  config = {
    bucket = "dev-cognism-tfstate-test2431"
    key    = "dev/vpc-demo/terraform.tfstate"
    region = "us-east-1"
  }
}