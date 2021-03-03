terraform {
  backend "s3" {
    bucket         = "dev-cognism-tfstate-test2431"
    key            = "dev/ecs-service-demo/terraform.tfstate"
    region         = "us-east-1"
  }
}